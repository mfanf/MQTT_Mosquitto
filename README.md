# Mosquitto MQTT broker

Docker-compose to run an authenticated/encrypted [Mosquitto](https://mosquitto.org/) MQTT broker.

## Authenticated
* comment ```require_certificate true``` in ```conf/mosquitto.conf```
* run ```docker-compose up```
* on a different terminal run ```mosquitto_sub -h localhost -p 8883 -t "#" -u admin -P admin``` to subscribe to any topic
* on a different terminal run ```mosquitto_pub -h localhost -p 8883 -t my/topic -m "message" -u admin -P admin``` to publish on the my/topic

Use the mosquitto_flow_NodeRED.json to create a flow in NodeRED with publisher/subscriber

* to add/change users use ```mosquitto_passwd -c /mosquitto/config/password.txt USER_NAME``` from the mosquitto container (```docker-compose exec mosquitto sh```)

## TSL encryption

* uncomment ```require_certificate true``` in ```conf/mosquitto.conf```
* run ```create_cert.sh``` to create keys and certificates for server and client
* run ```docker-compose up```
* on a different terminal run ```mosquitto_sub --cafile cert/ca.crt -h 192.168.1.109 -t "#" -p 8883 -d --cert client_cert/client.crt --key client_cert/client.key -u admin -P admin``` to subscribe to any topic
* on a different terminal run ```mosquitto_pub -h 192.168.1.109 -t "my/topic" -m "message" -p 8883 -d --cert client_cert/client.crt --key client_cert/client.key --cafile cert/ca.crt -u admin -P admin``` to publish on the my/topic

## Note:
* the ```.env``` file is used to avoid change of ownership of files when running the docker-compose. UID and GID are set to 1000, the default user for Ubuntu.

## references
* [Tutorial](https://medium.com/himinds/mqtt-broker-with-secure-tls-communication-on-ubuntu-18-04-lts-and-an-esp32-mqtt-client-5c25fd7afe67)
