# Mosquitto MQTT broker

## Authenticated
* comment ```require_certificate true``` in ```conf/mosquitto.conf```
* run docker-compose up -d
* on a different terminal run ```mosquitto_sub -h localhost -p 8883 -t "#" -u admin -P admin``` to subscribe to any topic
* on a different terminal run ```mosquitto_pub -h localhost -p 8883 -t my/topic -m "message" -u admin -P admin``` to publish on the my/topic

Use the mosquitto_flow_NodeRED.json to create a flow in NodeRED with publisher/subscriber

* to add/change users use ```mosquitto_passwd -c /mosquitto/config/password.txt USER_NAME``` from the mosquitto container (```docker-compose exec mosquitto sh```)

## TSL encryption

* uncomment ```require_certificate true``` in ```conf/mosquitto.conf```
* run create_cert.sh to create key and certificate for server and client
* run docker-compose up -d
* on a different terminal run ```mosquitto_sub --cafile cert/ca.crt -h 192.168.1.109 -t "#" -p 8883 -d --cert client_cert/client.crt --key client_cert/client.key -u admin -P admin``` to subscribe to any topic
* on a different terminal run ```mosquitto_pub -h 192.168.1.109 -t "my/topic" -m "message" -p 8883 -d --cert client_cert/client.crt --key client_cert/client.key --cafile cert/ca.crt -u admin -P admin``` to publish on the my/topic
