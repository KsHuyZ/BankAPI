makeFileDir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
DB_URL=postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable

postgres: 
	docker run --name postgres -p 2023:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=hihihi -d postgres:14-alpine

createdb:
	docker exec -it postgres createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres dropdb simple_bank
	
sqlc: 
	docker run --rm -v $(makeFileDir):/src -w /src kjconroy/sqlc generate

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb sqlc test

