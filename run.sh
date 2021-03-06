
uuid_list=''
for line in `env|grep '^UUID_.*'`
do 
    uuid=${line#*=}
    uuid_list="${uuid_list},{\"id\":\"${uuid}\",\"alterId\":${ALTER_ID}}"
done
uuid_list="${uuid_list:1}"

cp /etc/v2ray/config.json.tmp /etc/v2ray/config.json
sed -i "s/\$UUID_LIST/${uuid_list}/" /etc/v2ray/config.json
sed -i "s/\$RAY_PATH/${RAY_PATH}/" /etc/v2ray/config.json

caddy -agree -conf /etc/caddy/caddy.conf -email ${EMAIL} >&1 &
v2ray -config=/etc/v2ray/config.json
