#!/bin/bash

IP="192.168.1.109"
SUBJECT_CA="/C=IT/ST=Florence/L=Florence/O=test/OU=CA/CN=$IP"
SUBJECT_SERVER="/C=IT/ST=Florence/L=Florence/O=test/OU=Server/CN=$IP"
SUBJECT_CLIENT1="/C=IT/ST=Florence/L=Florence/O=test/OU=Admin/CN=$IP"
SUBJECT_CLIENT2="/C=IT/ST=Florence/L=Florence/O=test/OU=Anna/CN=$IP"
SUBJECT_CLIENT3="/C=IT/ST=Florence/L=Florence/O=test/OU=Roger/CN=$IP"

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
   echo "$SUBJECT_CLIENT1"
   openssl req -new -nodes -sha256 -subj "$SUBJECT_CLIENT1" -out client_cert/admin.csr -keyout client_cert/admin.key 
   openssl x509 -req -sha256 -in client_cert/admin.csr -CA cert/ca.crt -CAkey cert/ca.key -CAcreateserial -out client_cert/admin.crt -days 365
   
   echo "$SUBJECT_CLIENT2"
   openssl req -new -nodes -sha256 -subj "$SUBJECT_CLIENT2" -out client_cert/anna.csr -keyout client_cert/anna.key 
   openssl x509 -req -sha256 -in client_cert/anna.csr -CA cert/ca.crt -CAkey cert/ca.key -CAcreateserial -out client_cert/anna.crt -days 365
   
   echo "$SUBJECT_CLIENT3"
   openssl req -new -nodes -sha256 -subj "$SUBJECT_CLIENT3" -out client_cert/roger.csr -keyout client_cert/roger.key 
   openssl x509 -req -sha256 -in client_cert/roger.csr -CA cert/ca.crt -CAkey cert/ca.key -CAcreateserial -out client_cert/roger.crt -days 365
}

generate_CA
generate_server
generate_client
