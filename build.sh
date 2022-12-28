cp environment/psql/example.env environment/psql/.env
cp validator/docker/sample.env validator/docker/.env
docker-compose -f environment/kafka/docker-compose.yml stop
docker-compose -f environment/kafka/docker-compose.yml --env-file environment/kafka/.env up -d --build --force-recreate

docker-compose -f environment/psql/docker-compose.yml stop
docker-compose -f environment/psql/docker-compose.yml --env-file environment/psql/.env up -d --build --force-recreate
cd validator
./build.sh
