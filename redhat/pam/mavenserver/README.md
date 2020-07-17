1. Change the default admin password. The default user will have the following credentials predefined in the system:
> User: admin, Password: password
2. Configure LDAP settings (ref: ldap_settings.JPG) using Admin module left-hand side.
3. Logout and login with pamadmin user. Artifactory automatically adds the user to its user DB.
4. Logout and login with admin user. Add deploy permisson to libs-release-local and libs-snapshot-local repos for pamadmin.
