# farzadwebx
#### Doprax One Key Five Protocol Coexistence


#### The following variables are optional variables, add as required
| Variable meaning | Variable name | Variable specification value | When the variable name is not added, the final default result |
| :--- | :--- | :--- | :--- |
| Each protocol uuid or password | uuid | can be randomly generated on V2raN, or customize the uuid format |ea4909ef-7ca6-4b46-bf2e-6c07896ef338|
| Camouflage web page | www | Choose a number 8 or 9, a total of 2 camouflage web pages can be selected | Display Nginx welcome interface |
| Xray version | ver |[View the version number](https://github.com/XTLS/Xray-core/tags), the format is x.x.x, such as 1.7.1|Automatically update to the latest official version of Xray|
|Updating...|Updating...|Updating...|Updating...|
---------------
#### At present, the Cloudflare Argo tunnel domain name is automatically generated. After restarting the platform, the tunnel domain name will be reset forcibly. You must enter the open shell again and enter cat log to view

---------------
#### The short text of the client parameters of the five protocols is as follows:

Server address: domain name assigned by doprax, fill in custom, workers, argo domain name or self-selected IP in CDN

Port: 443

(http port: optional 80, 8080, 8880, 2052, 2082, 2086, 2095, tls must be closed)

(https port: optional 443, 2053, 2083, 2087, 2096, 8443, tls must be enabled)

Username, password, uuid: custom uuid

Encryption method/algorithm: ss is chacha20-ietf-poly1305, other protocols can be changed by default

Plugin (only for ss and socks): v2ray-plugin, it is recommended to turn off multiplexing

Transmission protocol/method: ws or websocket

Masquerade domain name host/sni: the domain name assigned by doprax or leave it blank, and fill in custom, workers, and argo domain names for CDN

The path of vless: /custom uuid-vl

The path of vmess: /custom uuid-vm

Trojan's path: /custom uuid-tr

The path of shadowsocks: /custom uuid-ss

The path of socks: /custom uuid-so

Transport Secure TLS: On

