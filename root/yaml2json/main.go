package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"log"
	"os"

	"gopkg.in/yaml.v3"
)

func main() {
	var b []byte
	var buf bytes.Buffer
	var e error
	var jenc *json.Encoder
	var m map[string]any

	if len(os.Args) < 2 {
		os.Exit(1)
	}

	if b, e = os.ReadFile(os.Args[1]); e != nil {
		log.Fatalf("failed to read file %s: %s\n", os.Args[1], e)
	}

	if e = yaml.Unmarshal(b, &m); e != nil {
		log.Fatalf("failed to parse YAML: %s\n", e)
	}

	jenc = json.NewEncoder(&buf)
	jenc.SetEscapeHTML(false)
	jenc.SetIndent("", "  ")

	if e = jenc.Encode(&m); e != nil {
		log.Fatalf("failed to convert to JSON: %s\n", e)
	}

	fmt.Print(buf.String())
}
