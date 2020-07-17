# Post Init Setup for LDAP
You need to change default user settings and configure LDAP to enable full integration of RHPAM ecosystem: 
* Change the default admin password. The default user will have the following credentials predefined in the system:
    - User: admin
    - Password: password
* Configure LDAP settings (ref: [ldap_settings.JPG](./ldap_settings.JPG)) using Admin module left-hand side.
* Logout and login with pamadmin user. Artifactory automatically adds the user to its user DB.
* Logout and login with admin user. Add deploy permisson to libs-release-local and libs-snapshot-local repos for pamadmin.
