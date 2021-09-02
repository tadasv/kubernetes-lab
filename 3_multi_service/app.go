package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"time"
)

func fetchData() (string, error) {
	client := &http.Client{
		Timeout: time.Second * 10,
	}

	resp, err := client.Get(os.Getenv("SERVICE_ADDRESS"))
	if err != nil {
		return "", err
	}
	defer resp.Body.Close()
	bytes, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return "", err
	}

	return string(bytes), nil
}

func main() {
	remoteFetch := os.Getenv("MODE") == "remote-fetch"

	log.Println("Starting Web App", remoteFetch)

	if remoteFetch {
		http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
			resp, err := fetchData()
			if err != nil {
				fmt.Fprintf(w, "failed to fetch data: %s\n", err.Error())
			} else {
				fmt.Fprintf(w, "response from remote service: %s\n", resp)
			}
		})
	} else {
		http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
			fmt.Fprintf(w, "Current time: %s\n", time.Now().String())
		})
	}

	listenAddress := os.Getenv("LISTEN_ADDRESS")
	if listenAddress == "" {
		listenAddress = ":8000"
	}
	http.ListenAndServe(listenAddress, nil)
}
