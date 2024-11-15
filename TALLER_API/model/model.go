package model

type Usuario struct {
	Id     uint   `json:"usuario_id"`
	Nombre string `json:"us_nombre"`
	Pass   string `json:"us_pass"`
	Activo bool   `json:"us_sactivo"`
}

type Libro struct {
	LibroID int    `json:"libro_id"`
	Nombre  string `json:"lib_nombre"`
	Autor   string `json:"lib_autor"`
	Genero  string `json:"lib_genero"`
}

/*
type estanteria struct {
	id uint `json:"id"`
}

type Review struct s
	id uint `json:"id"`
}
*/
