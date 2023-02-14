#!/bin/bash
apt update && apt install -y wget unzip
nx=$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 4)
xpid=$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 8)
[ -n "${ver}" ] && wget -O $nx.zip https://github.com/XTLS/Xray-core/releases/download/v${ver}/Xray-linux-64.zip
[ ! -s $nx.zip ] && wget -O $nx.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip
unzip $nx.zip xray && rm -f $nx.zip
wget https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat
wget https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat
chmod a+x xray && mv xray $xpid
sed -i "s/uuid/$uuid/g" ./config.json
sed -i "s/uuid/$uuid/g" /etc/nginx/nginx.conf
[ -n "${www}" ] && rm -rf /usr/share/nginx/* && wget -c -P /usr/share/nginx "https://github.com/yonggekkk/doprax-xray/raw/main/3w/html${www}.zip" && unzip -o "/usr/share/nginx/html${www}.zip" -d /usr/share/nginx/html
cat config.json | base64 > config
rm -f config.json

# argo fscarmen
rm -f cloudflared-linux-amd64*
wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
chmod +x cloudflared-linux-amd64
./cloudflared-linux-amd64 tunnel --url http://localhost:8080 --no-autoupdate > argo.log 2>&1 &
sleep 5
ARGO=$(cat argo.log | grep -oE "https://.*[a-z]+cloudflare.com" | sed "s#https://##")
xver=`./$xpid version | sed -n 1p | awk '{print $2}'`
UA_Browser="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.87 Safari/537.36"
v4=$(curl -s4m6 ip.sb -k)
v4l=`curl -sm6 --user-agent "${UA_Browser}" http://ip-api.com/json/$v4?lang=zh-CN -k | cut -f2 -d"," | cut -f4 -d '"'`

Argo_xray_vmess="vmess://$(echo -n "\
{\
\"v\": \"2\",\
\"ps\": \"Argo_xray_vmess\",\
\"add\": \"${ARGO}\",\
\"port\": \"443\",\
\"id\": \"$uuid\",\
\"aid\": \"0\",\
\"net\": \"ws\",\
\"type\": \"none\",\
\"host\": \"${ARGO}\",\
\"path\": \"/$uuid-vm\",\
\"tls\": \"tls\",\
\"sni\": \"${ARGO}\"\
}"\
    | base64 -w 0)" 
Argo_xray_vless="vless://${uuid}@${ARGO}:443?encryption=none&security=tls&sni=$ARGO&type=ws&host=${ARGO}&path=/$uuid-vl#Argo_xray_vless"
Argo_xray_trojan="trojan://${uuid}@${ARGO}:443?security=tls&type=ws&host=${ARGO}&path=/$uuid-tr&sni=$ARGO#Argo_xray_trojan"

cat > log << EOF
****************************************************************
================================================================
The official version of Xray currently installed: $xver
IP of the current network: $v4
IP affiliation area: $v4l
==================================================== ===============
Note: Refactor or restart the current platform, the Argo server address will be reset and updated
Cloudflared Argo tunnel mode Xray five protocol configuration is as follows:
==================================================== ===============
-------------------------------------------------- --------------
1: The plain text of Vmess+ws+tls configuration is as follows, the relevant parameters can be copied to the client
Argo server temporary address (can be changed to CDN self-selected IP): $ARGO
https port: optional 443, 2053, 2083, 2087, 2096, 8443, tls must be enabled
http port: optional 80, 8080, 8880, 2052, 2082, 2086, 2095, tls must be closed
uuid: $uuid
Transport protocol: ws
host/sni:$ARGO
path path: /$uuid-vm

The sharing link is as follows (default port 443, tls is enabled, the server address can be changed to a self-selected IP)
${Argo_xray_vmess}

-------------------------------------------------- --------------
2: The plain text of Vless+ws+tls configuration is as follows, the relevant parameters can be copied to the client
Argo server temporary address (can be changed to CDN self-selected IP): $ARGO
https port: optional 443, 2053, 2083, 2087, 2096, 8443, tls must be enabled
http port: optional 80, 8080, 8880, 2052, 2082, 2086, 2095, tls must be closed
uuid: $uuid
Transport protocol: ws
host/sni:$ARGO
path: /$uuid-vl

The sharing link is as follows (default port 443, tls is enabled, the server address can be changed to a self-selected IP)
${Argo_xray_vless}

-------------------------------------------------- --------------
3: Trojan+ws+tls configuration plain text is as follows, relevant parameters can be copied to the client
Argo server temporary address (can be changed to CDN self-selected IP): $ARGO
https port: optional 443, 2053, 2083, 2087, 2096, 8443, tls must be enabled
http port: optional 80, 8080, 8880, 2052, 2082, 2086, 2095, tls must be closed
Password: $uuid
Transport protocol: ws
host/sni:$ARGO
path path: /$uuid-tr

The sharing link is as follows (default port 443, tls is enabled, the server address can be changed to a self-selected IP)
${Argo_xray_trojan}

-------------------------------------------------- --------------
4: Shadowsocks+ws+tls configuration plain text is as follows, relevant parameters can be copied to the client
Argo server temporary address (can be changed to CDN self-selected IP): $ARGO
https port: optional 443, 2053, 2083, 2087, 2096, 8443, tls must be enabled
http port: optional 80, 8080, 8880, 2052, 2082, 2086, 2095, tls must be closed
Password: $uuid
Encryption method: chacha20-ietf-poly1305
Transport protocol: ws
host/sni:$ARGO
path path: /$uuid-ss

-------------------------------------------------- --------------
5: Socks+ws+tls configuration plain text is as follows, relevant parameters can be copied to the client
Argo server temporary address (can be changed to CDN self-selected IP): $ARGO
https port: optional 443, 2053, 2083, 2087, 2096, 8443, tls must be enabled
http port: optional 80, 8080, 8880, 2052, 2082, 2086, 2095, tls must be closed
Username: $uuid
Password: $uuid
Transport protocol: ws
host/sni:$ARGO
path path: /$uuid-so

-------------------------------------------------- --------------
If the current environment supports shell, enter cat log to view the current configuration information
****************************************************************
EOF
 
cat log
nginx
base64 -d config > config.json; ./$xpid -config=config.json
