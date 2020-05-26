#!/bin/bash

if [ ! -f /data/gitea/conf/init ]
then
	touch /data/gitea/conf/init && \
	gitea migrate --config /data/gitea/conf/app.ini && \
	gitea admin auth add-ldap-simple \
	--config /data/gitea/conf/app.ini \
	--name ldap \
	--security-protocol unencrypted \
	--host openldap \
	--port 389 \
	--user-search-base "ou=People,dc=corp,dc=com" \
	--user-dn "uid=%s,ou=People,dc=corp,dc=com" \
	--user-filter "(&(objectClass=organizationalPerson)(uid=%s))" \
	--admin-filter "(memberOf=cn=gitadmin,ou=Groups,dc=corp,dc=com)" \
	--email-attribute mail \
	--username-attribute uid \
	--firstname-attribute cn \
	--surname-attribute sn
fi

gitea web