## make the file executable: chmod +x rebuild.sh
## run the script: ./rebuild.sh

## Stop and remove all containers
docker-compose down
## Build all containers
docker-compose build
##  Builds, (re)creates, and starts containers
docker-compose -f docker-compose.yml up -d