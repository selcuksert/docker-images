# RedHat Process Automation Manager
## Git Integration
### Manual Method
* Clone project from BusinessCentral (Use RHPAM login user & pass):
    ```sh
    git clone http(s)://<BC_USER>:<BC_PASSWORD>@<BC_HOST:BC_PORT>/business-central/git/<SPACE_NAME>/<PROJECT_NAME>
    ```
     Example:
    ```sh
    git clone http://pamadmin:redhatpam1!@localhost:8080/business-central/git/MySpace/Employee_Rostering
    ```
* Create a repository with same project name in remote Git server
* Add remote repository and push it:
    ```sh
    cd <PROJECT_NAME>
    git remote add <REMOTE_REPO_NAME> http(s)://<REMOTE_GIT_URL>/<PROJECT_NAME>
    git push <REMOTE_REPO_NAME>
    ```
    Example:
    ```sh
    cd Employee_Rostering
	git remote add gitea http://rhpam:Rhpam1!@localhost:3000/rhpam/Employee_Rostering
	git push gitea
    ```