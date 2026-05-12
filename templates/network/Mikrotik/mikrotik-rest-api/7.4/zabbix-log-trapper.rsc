{
	:local zabbixApiToken "15a47ba157acd28372abf211eb63edda457790158b0517533d4f13ac3e9eb088";
	:local zabbixApiProtocol "http";
	:local zabbixApiHost "192.168.254.4";
	:local zabbixApiPort "8080";	
	:local zabbixApiEndpoint "$zabbixApiProtocol://$zabbixApiHost:$zabbixApiPort/api_jsonrpc.php";
	
	:local hostTrapper [/system/identity/get name];
	
	:local logValue {"topics"=$topics; "message"=$message};
	:set logValue [:serialize to=json options=json.no-string-conversion value=$logValue];
	
	:local data {"jsonrpc"="2.0"; "method"="history.push"; "params"={"host"="$hostTrapper"; "key"="log.trapper"; "value"=$logValue}; "id"=1};
	:set data [:serialize to=json options=json.no-string-conversion value=$data];
	
	:local trapper true;
	
	:if ($topics~"fetch") do={
		:set trapper false;
	}
	
	:if ($trapper) do={
		/tool/fetch url=$zabbixApiEndpoint http-header-field="Content-Type: application/json, Authorization: Bearer $zabbixApiToken" http-data=$data http-method=post	
	}
}
