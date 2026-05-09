# Mikrotik by REST API (v0.33)

Template para el monitoreo avanzado de dispositivos **Mikrotik** utilizando la **REST API** (introducida en RouterOS v7). Este template ofrece una alternativa moderna y eficiente al protocolo SNMP, optimizando la recolección de métricas críticas de sistema, red y seguridad.

## 🚀 Características Principales

* **Monitoreo de Salud y Hardware:** * Estado de ICMP (ping, pérdida y latencia).
    * **(Nuevo v0.32)** Descubrimiento y monitoreo de sensores (Voltaje, Temperatura, Fans).
    * **(Nuevo v0.32)** Estado general de salud del sistema vía REST.
* **Recursos del Sistema:** * Uso de CPU (total y por núcleo).
    * Utilización de memoria RAM.
    * **(Nuevo v0.32)** Monitoreo de Almacenamiento (HDD total, libre y % de uso).
    * **(Nuevo v0.32)** Identificación de versión de OS, Uptime y Arquitectura.
* **Seguridad y Firewall:** * **(Nuevo v0.32)** Monitoreo de Connection Tracking (entradas totales, IPv4, IPv6 y límites máximos).
* **Interfaces de Red:** * Descubrimiento automático de interfaces.
    * Tráfico (bps) y estadísticas de paquetes/errores.
    * Monitoreo detallado de módulos SFP (Potencia óptica RX/TX, temperatura).
* **BGP:** * Descubrimiento de sesiones BGP.
    * Estado de conexiones, conteo de prefijos y tráfico por sesión.
* **Inventario:** * Recolección automática de modelo, número de serie y firmware.

## 🛠️ Requisitos de Configuración

Para garantizar el funcionamiento correcto de la v0.33, asegúrese de cumplir con:

1. **RouterOS v7.x:** Probado y recomendado para versiones superiores a **v7.20**.
2. **Servicio Web habilitado:** El equipo debe tener habilitado el acceso HTTPS (`/ip service set www-ssl disabled=no`).
3. **Permisos de Usuario:** El usuario de la API requiere permisos de `read` y `api`.

### Macros Requeridas

Configure estas macros en el Host o a nivel de Template:

| Macro | Descripción | Valor Predeterminado |
| :--- | :--- | :--- |
| `{$REST_API_HOST}` | Dirección IP o FQDN del Mikrotik | `{HOST.CONN}` |
| `{$REST_API_USER}` | Usuario con acceso a la API | - |
| `{$REST_API_PASSWORD}` | Contraseña del usuario | - |
| `{$REST_API_PORT}` | Puerto del servicio (SSL recomendado) | `443` |
| `{$REST_API_PROTOCOL}` | Protocolo de conexión | `https` |

## 📊 Dashboards Incluidos

El template incluye dashboards optimizados (v0.33 con layout mejorado):
* **Main Dashboard:** Vista general de salud, CPU, memoria y firewall.
* **Network Interfaces:** Tráfico detallado y estadísticas de errores.
* **Storage & Health:** (Nuevo) Visualización del estado del disco y sensores de hardware.
* **BGP Status:** Monitoreo de sesiones y prefijos.

## ⚠️ Triggers Principales

* **Firewall Tracking Full:** Alerta si las conexiones del firewall alcanzan niveles críticos.
* **Low Storage Space:** Notificación si el espacio en disco es insuficiente.
* **BGP Session Down:** Alerta de alta prioridad si una sesión BGP se interrumpe.
* **High CPU/Memory Usage:** Umbrales configurados para detectar saturación de recursos.

## 📝 Historial de Versiones

* **v0.33:** Optimización visual de dashboards y refinamiento de widgets.
* **v0.32:** Adición masiva de monitoreo de firewall, salud del sistema y almacenamiento.
* **v0.26:** Versión inicial estable con soporte BGP y SFP.

---
**Autor:** David Alejos  
**Versión del Template:** 7.4 | **Grupo:** Templates/Network devices
