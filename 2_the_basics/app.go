package main

import (
	"log"
	"net/http"
)

func main() {
	log.Println("Starting Web App")
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("Hello from Kubernetes"))
	})
	http.ListenAndServe(":8000", nil)
}
