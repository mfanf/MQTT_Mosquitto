# Mosquitto MQTT broker

* run docker-compose up -d
* on a different terminal run ```mosquitto_sub -h localhost -p 1883 -t my/topic -u admin -P admin``` to subscribe to the my/topic topic
* on a different terminal run ```mosquitto_pub -h localhost -p 1883 -t my/topic -m "message" -u admin -P admin``` to publich on the my/topic

Use the mosquitto_flow_NodeRED.json to create a flow in NodeRED with publisher/subscriber

* to add/change users use ```mosquitto_passwd -c /mosquitto/config/password.txt USER_NAME``` from the mosquitto container (```docker-compose exec mosquitto sh```)
