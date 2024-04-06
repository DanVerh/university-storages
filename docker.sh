docker run -d \
--name autoservice-db \
-p 5432:5432 \
-e POSTGRES_DB=autoservice \
-e POSTGRES_USER=user \
-e POSTGRES_PASSWORD=password \
-v ~/Documents/University/storage/db-volume:/var/lib/postgresql/data \
postgres:14-alpine

docker cp ~/Documents/University/storage/insert-data/ autoservice-db:/tmp