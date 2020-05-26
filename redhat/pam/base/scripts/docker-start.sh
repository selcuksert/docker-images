#!/bin/bash

NO_OF_PARAMS=10
LDAP_HOST=$1
LDAP_PORT=$2
BIND_DN=$3
BIND_PASS=$4
KIE_CONT_USER=$5
KIE_CONT_PASS=$6
KIE_SRV_USER=$7
KIE_SRV_PASS=$8
MVN_HOST=$9
MVN_PORT=${10}

if [[ $# -ne $NO_OF_PARAMS ]]; then
    echo "Illegal number of parameters ($#). Must be $NO_OF_PARAMS!"
    exit 2
fi

until nc -z -v $LDAP_HOST $LDAP_PORT
do
    echo "$LDAP_HOST:$LDAP_PORT is NOT Alive"
	sleep 3
done

echo "$LDAP_HOST:$LDAP_PORT is ALIVE"

until nc -z -v $MVN_HOST $MVN_PORT
do
    echo "$MVN_HOST:$MVN_PORT is NOT Alive"
	sleep 3
done

echo "$MVN_HOST:$MVN_PORT is ALIVE"


cp $JBOSS_HOME/standalone/configuration/standalone-full-param.xml $JBOSS_HOME/standalone/configuration/standalone-full.xml

sed "s/LDAP_HOST/$LDAP_HOST/g" -i $JBOSS_HOME/standalone/configuration/standalone-full.xml
sed "s/LDAP_PORT/$LDAP_PORT/g" -i $JBOSS_HOME/standalone/configuration/standalone-full.xml
sed "s/BIND_DN/$BIND_DN/g" -i $JBOSS_HOME/standalone/configuration/standalone-full.xml
sed "s/BIND_PASS/$BIND_PASS/g" -i $JBOSS_HOME/standalone/configuration/standalone-full.xml
sed "s/KIE_CONT_USER/$KIE_CONT_USER/g" -i $JBOSS_HOME/standalone/configuration/standalone-full.xml
sed "s/KIE_CONT_PASS/$KIE_CONT_PASS/g" -i $JBOSS_HOME/standalone/configuration/standalone-full.xml
sed "s/KIE_SRV_USER/$KIE_SRV_USER/g" -i $JBOSS_HOME/standalone/configuration/standalone-full.xml
sed "s/KIE_SRV_PASS/$KIE_SRV_PASS/g" -i $JBOSS_HOME/standalone/configuration/standalone-full.xml

standalone.sh -c standalone-full.xml -b 0.0.0.0 -bmanagement 0.0.0.0
