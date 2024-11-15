/*
package conn

import (
	"database/sql"
	"log"

	_ "github.com/lib/pq"
)

func initDB() {
	connStr := "postgres://postgres:@pr-final@localhost:5432/biblioteca?sslmode=disable"
	db, err := sql.Open("postgres", connStr)
	defer db.Close()

	if err != nil {
		log.Fatal(err)
	}

	if err = db.Ping(); err != nil {
		log.Fatal(err)
	}

}

// Create new user func

// Create new book ADMIN func

// Insert new book on user bookshelf func

// Delete book ADMIN func
// Delete book from bookshelf func

// Search for books
