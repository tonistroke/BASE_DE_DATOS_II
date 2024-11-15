package conn_db

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/lib/pq"
)

func InitDB() {
	connStr := "postgres://postgres:pr-apibiblio@localhost:5432/biblioteca?sslmode=disable"
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println("Succesful connection to DB")
	defer db.Close()

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
