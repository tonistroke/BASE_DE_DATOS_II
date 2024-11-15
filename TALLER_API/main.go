package main

import (
	"database/sql"
	"encoding/json"
	"log"
	"net/http"
	"strconv"

	"api_biblioteca.com/model"
	_ "github.com/lib/pq"
)

var db *sql.DB

// Conexión a la base de datos
/*
func initDB() {
	var err error
	connStr := "postgres://postgres:@pr-final@localhost:5345/biblioteca?sslmode=disable"
	db, err = sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal(err)
	}
}
*/

// Insertar usuarioo
func Insertar_usuarioDB(w http.ResponseWriter, r *http.Request) {
	var usuario model.Usuario
	if err := json.NewDecoder(r.Body).Decode(&usuario); err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	_, err := db.Exec("CALL nuevo_usuario($1, $2)", usuario.Nombre, usuario.Pass)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
}

// Función para insertar un libro
func insertLibro(w http.ResponseWriter, r *http.Request) {
	var libro model.Libro
	if err := json.NewDecoder(r.Body).Decode(&libro); err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	_, err := db.Exec("SELECT insert_libro($1, $2, $3)", libro.Nombre, libro.Autor, libro.Genero)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusCreated)
}

// eliminar un libro
func deleteLibro(w http.ResponseWriter, r *http.Request) {
	id, err := strconv.Atoi(r.URL.Query().Get("id"))
	if err != nil {
		http.Error(w, "ID inválido", http.StatusBadRequest)
		return
	}

	_, err = db.Exec("SELECT delete_libro($1)", id)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusNoContent)
}

// obtener todos los libros
func listaLibros(w http.ResponseWriter) { // lista_libros
	rows, err := db.Query("SELECT * FROM lista_libros")
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	var libros []model.Libro
	for rows.Next() {
		var libro model.Libro
		if err := rows.Scan(&libro.LibroID, &libro.Nombre, &libro.Autor, &libro.Genero); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		libros = append(libros, libro)
	}

	json.NewEncoder(w).Encode(libros)
}

// Función para obtener libros por género
func librosByGenero(w http.ResponseWriter, r *http.Request) {
	genero := r.URL.Query().Get("genero")
	rows, err := db.Query("SELECT * FROM libros_by_genero($1)", genero)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	var libros []model.Libro
	for rows.Next() {
		var libro model.Libro
		if err := rows.Scan(&libro.LibroID, &libro.Nombre, &libro.Autor, &libro.Genero); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		libros = append(libros, libro) // añadir libro a lista cache
	}

	json.NewEncoder(w).Encode(libros) // convertir lista chache a formato Json
}

func main() {
	// __________________________ coneccion BD __________________________
	connStr := "postgres://postgres:@pr-final@localhost:5432/biblioteca?sslmode=disable"
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal(err)
	}

	defer db.Close()

	if err = db.Ping(); err != nil {
		log.Fatal(err)
	}

	// __________________________ Handle functions __________________________
	http.HandleFunc("/libros", func(w http.ResponseWriter, r *http.Request) {
		if r.Method == http.MethodGet {
			listaLibros(w)
		} else if r.Method == http.MethodPost {
			insertLibro(w, r)
		} else {
			http.Error(w, "Método no permitido", http.StatusMethodNotAllowed)
		}
	})

	http.HandleFunc("/libros/genero", librosByGenero)
	http.HandleFunc("/libros/delete", deleteLibro)

	log.Println("API escuchando en http://localhost:8088")
	log.Fatal(http.ListenAndServe(":8088", nil))
}
