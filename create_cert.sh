#!/bin/bash

IP="192.168.1.109"
SUBJECT_CA="/C=IT/ST=Florence/L=Florence/O=test/OU=CA/CN=$IP"
SUBJECT_SERVER="/C=IT/ST=Florence/L=Florence/O=test/OU=Server/CN=$IP"
SUBJECT_CLIENT="/C=IT/ST=Florence/L=Florence/O=test/OU=Client/CN=$IP"

function generate_CA () {
   echo "$SUBJECT_CA"
   openssl req -x509 -nodes -sha256 -newkey rsa:2048 -subj "$SUBJECT_CA"  -days 365 -keyout cert/ca.key -out cert/ca.crt
}

function generate_server () {
   echo "$SUBJECT_SERVER"
   openssl req -nodes -sha256 -new -subj "$SUBJECT_SERVER" -keyout cert/server.key -out cert/server.csr
   openssl x509 -req -sha256 -in cert/server.csr -CA cert/ca.crt -CAkey cert/ca.key -CAcreateserial -out cert/server.crt -days 365
}

function generate_client () {
   echo "$SUBJECT_CLIENT"
   openssl req -new -nodes -sha256 -subj "$SUBJECT_CLIENT" -out client_cert/client.csr -keyout client_cert/client.key 
   openssl x509 -req -sha256 -in client_cert/client.csr -CA cert/ca.crt -CAkey cert/ca.key -CAcreateserial -out client_cert/client.crt -days 365
}

generate_CA
generate_server
generate_client
