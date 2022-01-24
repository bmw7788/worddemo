#!/bin/sh

# Download and install xRay
mkdir /tmp/wordpress
curl -L -H "Cache-Control: no-cache" -o /tmp/worddemo/worddemo.zip https://github.com/XTLS/Xray-core/releases/download/v1.4.2/Xray-linux-64.zip
unzip /tmp/worddemo/worddemo.zip -d /tmp/worddemo
install -m 755 /tmp/worddemo/worddemo /usr/local/bin/worddemo

# Remove temporary directory
rm -rf /tmp/worddemo

# XRay new configuration
install -d /usr/local/etc/worddemo
cat << EOF > /usr/local/etc/worddemo/config.json
{
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "$UUID",
                        "level": 0
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

# Run XRay
/usr/local/bin/worddemo -config /usr/local/etc/worddemo/config.json
