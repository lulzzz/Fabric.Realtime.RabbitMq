#!/bin/bash

set -eu

if [ ! -f /opt/healthcatalyst/client/cert.pem ]
then
	echo "no certificates found so regenerating them"
	/bin/bash /opt/healthcatalyst/setupca.sh \
		&& /bin/bash /opt/healthcatalyst/generateservercert.sh Imran \
		&& /etc/init.d/rabbitmq-server restart
		
	/bin/bash /opt/healthcatalyst/generateclientcert.sh Imran \
		&& /etc/init.d/rabbitmq-server stop
fi

exec rabbitmq-server