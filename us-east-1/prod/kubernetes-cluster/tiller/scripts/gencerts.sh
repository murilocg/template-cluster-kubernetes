#!/bin/bash


TF_OUTPUT="$(yes | terragrunt output-all -json | jq -s add )"
CONFIG_PATH=$1
certs="helm_client_tls_private_key_pem helm_client_tls_public_cert_pem helm_client_tls_ca_cert_pem"
mkdir -p ./.secret
for i in `echo $certs`; do
  cert="$(echo ${TF_OUTPUT} | jq -r .$i.value)"
  echo -e "$cert" > CONFIG_PATH/$i.pem
done
