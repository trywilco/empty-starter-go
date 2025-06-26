package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"

	_ "github.com/lib/pq"
)

func main() {
	// Connect to database
	db := connectDB()
	defer db.Close()

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "Hello, Go Quiz API! 🐹")
	})

	fmt.Println("🚀 Server starting on port 8080...")
	log.Fatal(http.ListenAndServe(":8080", nil))
}

func connectDB() *sql.DB {
	connStr := "host=postgres port=5432 user=quiz_user password=quiz_password dbname=quiz_db sslmode=disable"
	
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal("Failed to connect to database:", err)
	}
	
	if err = db.Ping(); err != nil {
		log.Fatal("Failed to ping database:", err)
	}
	
	fmt.Println("✅ Connected to database")
	return db
}
