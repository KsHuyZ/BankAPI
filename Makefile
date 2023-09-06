makeFileDir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

postgres: 
	docker run --name postgres -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:14-alpine
createdb:
	docker exec -it postgres createdb --username=root --owner=root simple_bank
dropdb:
	docker exec -it postgres dropdb simple_bank
	
sqlc: 
	docker run --rm -v $(makeFileDir):/src -w /src kjconroy/sqlc generate

.PHONY: postgres createdb dropdb sqlc

