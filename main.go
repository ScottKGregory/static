package main

import (
	"flag"
	"fmt"
	"net/http"
	"os"
	"strings"
)

func main() {
	files := flagOrEnv("files", "/var/static", "Filepath to host files from")
	port := flagOrEnv("port", "8080", "The port to host files on")
	flag.Parse()

	fs := http.FileServer(http.Dir(*files))
	http.Handle("/", fs)

	fmt.Printf("Starting file server on port %s, with directory %s\n", *port, *files)
	http.ListenAndServe(fmt.Sprintf(":%s", *port), nil)
}

func flagOrEnv(key, def, desc string) (val *string) {
	envKey := fmt.Sprintf("$STATIC_%s", strings.ToUpper(key))
	env := os.ExpandEnv(envKey)
	if env == "" {
		env = def
	}

	val = flag.String(key, env, desc)

	return val
}
