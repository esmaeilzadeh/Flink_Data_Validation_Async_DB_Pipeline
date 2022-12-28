docker-compose -f environment/kafka/docker-compose.yml up -d
docker-compose -f environment/psql/docker-compose.yml up -d
docker-compose -f validator/docker/docker-compose.yml up -d
