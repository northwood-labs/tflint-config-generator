package main

import (
	"bytes"
	"embed"
	"flag"
	"log"
	"os"
	"text/template"
)

//go:embed *.tmpl.hcl
var content embed.FS

func main() {
	rulesPtr := flag.String("rules", "", "One of no value, 'aws', 'gcp', 'azure'.")
	rulesTagPtr := flag.String("rules-tag", "", "Should match a specific Git tag for the repo.")

	flag.Parse()

	baseTmpl := baseTemplate() // lint:edge_case_be_quiet_linter

	if *rulesPtr == "aws" {
		overlayTemplate("_aws.tmpl.hcl", baseTmpl, "_aws.tflint.hcl.tmp", *rulesTagPtr)
	} else if *rulesPtr == "gcp" {
		overlayTemplate("_gcp.tmpl.hcl", baseTmpl, "_gcp.tflint.hcl.tmp", *rulesTagPtr)
	} else if *rulesPtr == "azure" {
		overlayTemplate("_azure.tmpl.hcl", baseTmpl, "_azure.tflint.hcl.tmp", *rulesTagPtr)
	}
}

func templateFormatWrite(tmpl *template.Template, writeFileName string, params map[string]interface{}) {
	// File permissions that are also friendly to Windows machines.
	const filePerms = 0o666

	var buf bytes.Buffer

	if err := tmpl.Execute(&buf, params); err != nil {
		log.Fatal(err)
	}

	err := os.WriteFile(writeFileName, buf.Bytes(), filePerms) // lint:allow_666
	if err != nil {
		log.Fatal(err)
	}
}

// Base configuration for non-cloud Terraform projects (e.g., New Relic,
// PagerDuty, Cloudflare).
func baseTemplate() *template.Template {
	baseHCL, err := content.ReadFile("_base.tmpl.hcl")
	if err != nil {
		log.Fatal(err)
	}

	baseTmpl, err := template.New("base").Parse(string(baseHCL))
	if err != nil {
		log.Fatal(err)
	}

	templateFormatWrite(baseTmpl, "base.tflint.hcl", map[string]interface{}{})

	return baseTmpl
}

func overlayTemplate(templateFileName string, baseTemplate *template.Template, writeFileName, tag string) {
	overlayHCL, err := content.ReadFile(templateFileName)
	if err != nil {
		log.Fatal(err)
	}

	overlayTmpl, err := template.Must(baseTemplate.Clone()).Parse(string(overlayHCL))
	if err != nil {
		log.Fatal(err)
	}

	templateFormatWrite(overlayTmpl, writeFileName, map[string]interface{}{
		"tag": tag,
	})
}
