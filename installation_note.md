---
geometry: margin=2cm
output: pdf_document
---

## rjtools package installation

- install *lbxml2-dev* (for Debian, Ubuntu) - which is for RPi OS
- go into RStudio or using `R` command in the terminal:
	- install *xml2* and *distill*
	``` r
	install.packages("xml2")
	install.packages("distill")
	```
	- rjtools installation
	``` r
	install.packages("remotes")
	remotes::install_github("rjournal/rjtools")
	```
- *rjtools* should now be installed

## about rjtools

- https://rjournal.github.io/rjtools/
- https://github.com/rjournal/rjtools/
- trying put the tools
- either open RStudio's web console or use *R* in Linux's terminal
	- navigaiton: getwd(), setwd(), list.files()
	- tools::texi2pdf("path/to/file") to convert tex to pdf
