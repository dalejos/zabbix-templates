# MikroTik Log Trapper to Zabbix API

Este script permite enviar logs de MikroTik RouterOS directamente a Zabbix utilizando el m谷todo `history.push` de la API de Zabbix (disponible en versiones recientes). A diferencia del protocolo SNMP, este m谷todo utiliza la REST API para empujar datos de forma estructurada en formato JSON.

## ?? Funcionamiento

El script captura los eventos del log (mensaje y t車picos), los serializa en un objeto JSON y los env赤a mediante un `POST` HTTP al endpoint de Zabbix. Incluye una l車gica de exclusi車n para evitar bucles infinitos (ignora logs generados por la propia herramienta `fetch`).

### El flujo de datos:
1. El sistema de logging de MikroTik detecta un evento.
2. Se ejecuta el script pasando las variables `$topics` y `$message`.
3. El script construye un payload JSON compatible con Zabbix.
4. Se env赤a el dato al 赤tem con llave `log.trapper` en el host correspondiente.

## ?? Instalaci車n y Configuraci車n

### 1. Configuraci車n en Zabbix
* **Host:** Debe tener un nombre que coincida exactamente con el `Identity` de su MikroTik.
* **Token:** Genere un *API Token* en Zabbix con permisos de escritura para el host.

### 2. Agregar el Script en MikroTik
Copie y pegue el siguiente comando en la terminal, asegur芍ndose de completar sus credenciales:

```routeros
/system/script/add name=zabbix_log_trapper source={
	:local zabbixApiToken "TU_TOKEN_AQUI";
	:local zabbixApiProtocol "https";
	:local zabbixApiHost "tu.servidor.zabbix";
	:local zabbixApiPort "8080";	
	:local zabbixApiEndpoint "$zabbixApiProtocol://$zabbixApiHost:$zabbixApiPort/api_jsonrpc.php";
	
	:local hostTrapper [/system/identity/get name];
	
	:local logValue {"topics"=$topics; "message"=$message};
	:set logValue [:serialize to=json options=json.no-string-conversion value=$logValue];
	
	:local data {"jsonrpc"="2.0"; "method"="history.push"; "params"={"host"="$hostTrapper"; "key"="log.trapper"; "value"=$logValue}; "id"=1};
	:set data [:serialize to=json options=json.no-string-conversion value=$data];
	
	:local trapper true;
	
	# Evita bucles infinitos ignorando los logs del propio fetch
	:if ($topics~"fetch") do={
		:set trapper false;
	}
	
	:if ($trapper) do={
		/tool/fetch url=$zabbixApiEndpoint http-header-field="Content-Type: application/json, Authorization: Bearer $zabbixApiToken" http-data=$data http-method=post	
	}
}

/system/logging/action/add name=zabbix-trapper script=zabbix_log_trapper

/system/logging/add topics=error action=zabbix-trapper
/system/logging/add topics=warning action=zabbix-trapper
/system/logging/add topics=info action=zabbix-trapper