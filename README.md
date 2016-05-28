# docker-codecommit-deploy

Deploy docker-compose.yml file from AWS CodeCommit repo

## Use

```
docker run \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -e "COMPOSE_PROJECT_NAME=my-app" \
  -e "REPO=https://git-codecommit.us-east-1.amazonaws.com/v1/repos/repo-name" \
  -e "INTERVAL=60" \
  reflectivecode/docker-codecommit-deploy
```
