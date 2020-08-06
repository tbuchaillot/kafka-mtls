#!/bin/bash

set -e


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

source utils.sh
verify_installed "docker-compose"
verify_installed "keytool"

OLDDIR=$PWD

cd ${OLDDIR}/certs

log "Generate keys and certificates used for SSL"


./create_certs.sh > /dev/null 2>&1

cd ${OLDDIR}

docker-compose up -d

log "Waiting 10 seconds to warmup..."

sleep 10

log "Boker url: localhost:9092"
log "Broker client_id: 1"
log "ssl_cer: ${OLDDIR}/certs/client.certificate.pem"
log "ssl_key: ${OLDDIR}/certs/client.key"



