package main

import (
	"fmt"
	"net/http"
)

func main() {
	mux := http.NewServeMux()
	mux.HandleFunc("/", HandleRoot)

	fmt.Println("Listen in port: 8088")
	http.ListenAndServe(":8088", mux)
}

func HandleRoot(w http.ResponseWriter, r *http.Request) { fmt.Fprintf(w, "Hello world") }
