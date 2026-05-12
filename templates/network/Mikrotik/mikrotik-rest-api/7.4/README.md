# Mikrotik by REST API (v0.34)

Template para el monitoreo avanzado de dispositivos **Mikrotik** utilizando la **REST API** introducida en RouterOS v7. Ofrece una alternativa moderna al monitoreo por SNMP para recolectar metricas criticas de sistema, red, seguridad y routing.

## Caracteristicas Principales

* **Monitoreo de salud y hardware:** ICMP ping, perdida, latencia, sensores de voltaje, temperatura, fans y estado general de salud via REST.
* **Recursos del sistema:** CPU total y por nucleo, memoria RAM, almacenamiento, version de RouterOS, uptime y arquitectura.
* **Seguridad y firewall:** Connection Tracking con entradas totales, IPv4, IPv6 y limites maximos.
* **Interfaces de red:** Descubrimiento automatico, trafico en bps, estadisticas de paquetes/errores y monitoreo detallado de modulos SFP.
* **BGP:** Descubrimiento de sesiones, estado de conexiones, conteo de prefijos y trafico por sesion.
* **OSPFv2 (nuevo v0.34):** Soporte para RouterOS 7.20+ via REST API.
    * Descubrimiento de vecinos OSPFv2.
    * Monitoreo de estado, adjacency, state changes, DB summaries, LS requests y LS retransmits.
    * Conteo agregado de vecinos, vecinos fuera de estado `full` y LSAs.
    * Descubrimiento de LSAs por instancia, area y tipo, con conteo total, self-originated y max age.
    * Normalizacion del estado de vecinos para manejar respuestas de RouterOS como `Full`.
* **Inventario:** Recoleccion automatica de modelo, numero de serie, firmware y datos principales del equipo.

## Requisitos de Configuracion

Para garantizar el funcionamiento correcto de la v0.34, asegurese de cumplir con:

1. **RouterOS v7.x:** recomendado para versiones superiores a **v7.20**.
2. **Servicio web habilitado:** el equipo debe tener habilitado HTTPS mediante `www-ssl`.
3. **Permisos de usuario:** el usuario de la REST API requiere permisos de lectura y acceso REST/API segun la version de RouterOS.
4. **TLS compatible:** si Zabbix usa OpenSSL 3, configure un certificado valido para `www-ssl` y TLS 1.2 para evitar errores de handshake.

Ejemplo recomendado para HTTPS:

```routeros
/ip service set www-ssl disabled=no port=443 certificate=zabbix-www tls-version=only-1.2
```

## Macros Requeridas

Configure estas macros en el host o a nivel de template:

| Macro | Descripcion | Valor predeterminado |
| :--- | :--- | :--- |
| `{$REST_API_HOST}` | Direccion IP o FQDN del Mikrotik | `{HOST.CONN}` |
| `{$REST_API_USER}` | Usuario con acceso a la REST API | - |
| `{$REST_API_PASSWORD}` | Password del usuario | - |
| `{$REST_API_PORT}` | Puerto del servicio web | `443` |
| `{$REST_API_PROTOCOL}` | Protocolo de conexion | `https` |
| `{$OSPFV2_INSTANCE.MATCHES}` | Expresion regular para filtrar instancias OSPFv2. Usar `.*` para incluir todas. | `.*` |

## Dashboards Incluidos

* **Network interfaces:** trafico detallado y estadisticas de errores.
* **Network interfaces + SFP monitor:** metricas opticas RX/TX y temperatura SFP.
* **System health:** sensores de temperatura, voltaje, potencia y fans.
* **System resource:** CPU, memoria, almacenamiento, firewall entries, problemas e ICMP.
* **OSPFv2:** vecinos, vecinos no full, LSAs y graficos prototipo de colas link-state.

## Triggers Principales

* **Interface down:** alerta si una interfaz descubierta deja de estar running.
* **BGP session down:** alerta de alta prioridad si una sesion BGP se interrumpe.
* **OSPFv2 neighbors not full:** alerta si uno o mas vecinos OSPFv2 dejan de estar en estado `full`.
* **OSPFv2 neighbor not full:** alerta por vecino si su estado individual no es `full`.
* **System health temperature:** alerta si un sensor de temperatura supera el umbral configurado en la plantilla.

## OSPFv2 en RouterOS 7.20+

La implementacion usa endpoints REST de RouterOS v7:

* `/rest/routing/ospf/instance/print`
* `/rest/routing/ospf/neighbor/print`
* `/rest/routing/ospf/lsa/print`

El menu de vecinos y LSAs no expone directamente `version=2` en todos los casos, por eso el template incluye `{$OSPFV2_INSTANCE.MATCHES}`. Si el router tambien ejecuta OSPFv3, ajuste esa macro para que coincida solo con las instancias OSPFv2, por ejemplo:

```text
instance-v2|backbone-v2
```

En condiciones sanas se espera:

```text
state = full
DB summaries = 0
LS requests = 0
LS retransmits = 0
```

## Historial de Versiones

* **v0.34:** Agregado monitoreo OSPFv2 para RouterOS 7.20+: vecinos, estado `full`, contadores de LSDB, resumen de LSAs, dashboard y macro `{$OSPFV2_INSTANCE.MATCHES}`.
* **v0.33:** Optimizacion visual de dashboards y refinamiento de widgets.
* **v0.32:** Adicion masiva de monitoreo de firewall, salud del sistema y almacenamiento.
* **v0.26:** Version inicial estable con soporte BGP y SFP.

---

**Autor:** David Alejos  
**Version del Template:** 7.4 | **Grupo:** Templates/Network devices
