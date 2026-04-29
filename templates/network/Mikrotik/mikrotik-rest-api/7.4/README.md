# Mikrotik by REST API

Template para el monitoreo de dispositivos **Mikrotik** utilizando la **REST API** (introducida en RouterOS v7). Este template permite una recolección de datos eficiente sin depender exclusivamente de SNMP, permitiendo obtener métricas de salud, interfaces y sesiones BGP.

## 🚀 Características
* **Monitoreo de Salud:** Estado de ICMP (ping, pérdida de paquetes y tiempo de respuesta).
* **Recursos del Sistema:** Uso de CPU (total y por núcleo), utilización de memoria RAM y almacenamiento.
* **Interfaces de Red:** * Descubrimiento automático de interfaces activas.
    * Tráfico de red (bits por segundo) y estadísticas de paquetes.
    * Monitoreo detallado de interfaces Ethernet y módulos SFP (potencia RX/TX, temperatura).
* **BGP:** Descubrimiento de sesiones BGP, estado de la conexión, conteo de prefijos y tráfico por sesión.
* **Inventario:** Recolección automática de modelo, número de serie, versión de firmware y arquitectura.

## 🛠️ Configuración
Para que el template funcione correctamente, asegúrate de cumplir con los siguientes requisitos:

1. **RouterOS v7 (probado en +v7.20)** (necesario para el soporte de REST API).
2. Servidor web habilitado en el Mikrotik (`/ip service set www-ssl disabled=no`).
3. Usuario con permisos de `read` y `api` para las consultas.

### Macros Obligatorias
Debes configurar las siguientes macros en el Host o a nivel de Template:

| Macro | Descripción | Valor Predeterminado |
| :--- | :--- | :--- |
| `{$REST_API_HOST}` | Dirección IP o FQDN del dispositivo | - |
| `{$REST_API_USER}` | Usuario con acceso a la API | - |
| `{$REST_API_PASSWORD}` | Contraseña del usuario | - |
| `{$REST_API_PORT}` | Puerto del servicio HTTPS | `443` |
| `{$REST_API_PROTOCOL}` | Protocolo de conexión | `https` |

## 📊 Dashboards Incluidos
El template incorpora cuadros de mando preconfigurados:
* **Network interfaces:** Tráfico de red y estadísticas de errores por interfaz.
* **Network interfaces + SFP monitor:** Monitoreo específico para interfaces de fibra.
* **System resource:** Visualización de carga de CPU (por core) y consumo de memoria.

## ⚠️ Triggers Principales
* **BGP closed session:** Alerta de alta prioridad si una sesión BGP se cierra.
* **Interface running:** Alerta si una interfaz cambia su estado de *running* a *down*.
* **ICMP loss:** Detecta pérdida de paquetes hacia el dispositivo.

---
**Autor:** David Alejos  
**Versión del Template:** 7.4 | **Grupo:** Templates/Network devices
