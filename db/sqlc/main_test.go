package db

import (
	"database/sql"
	"log"
	"os"
	"testing"
	_ "github.com/lib/pq"
)

const (
	dbDriver = "postgres"
	dbSource = "postgresql://root:hihihi@localhost:2023/simple_bank?sslmode=disable"
)

var testQueries *Queries

func TestMain(m *testing.M) {
	con, err := sql.Open(dbDriver, dbSource)
	if err != nil {
		log.Fatal("cannot connect to db: ", err)
	}
	testQueries = New(con)
	os.Exit(m.Run())
}
