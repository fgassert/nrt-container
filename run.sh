#Change the NAME variable with the name of your script
NAME=nrt-container

docker build -t $NAME --build-arg NAME=$NAME .
docker run -v /var/run/docker.sock:/var/run/docker.sock --env-file .env $NAME
