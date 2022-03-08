---
geometry: margin=2cm
ouput: pdf_document
---

Source: [R Journal submission guide](https://journal.r-project.org/submissions.html)

Please read the [Instructions for Authors](https://journal.r-project.org/dev/submissions.html), which explains how to prepare an article for submission to *The R Journal*.

The following files provide the mandatory template for preparing an article for submission to the R Journal:
	- LaTeX style file: RJournal.sty.
	- fake Master LaTeX file: RJwrapper.tex.
	- article template: RJtemplate.tex (including figure: Rlogo-5.png and bibliography: RJreferences.bib).
	- example typeset template file: RJwrapper_orig.pdf.

Download [the zip archive of template files](https://journal.r-project.org/share/RJtemplate.zip) into a directory, run tools::texi2pdf inside R a couple of times on RJwrapper.tex to produce a file RJwrapper.pdf, which shows how the template file would be typeset in an issue of The R Journal.

Submissions not using this template will be rejected without consideration. Do check that you are using at least version 0.13 of the LaTeX style file: RJournal.sty; the current version is contained in the zip archive of template files.

-------------

## Overall requirements
- short to medium, no more than 20 pages
- inclusion:
	- .Rmd
	- .tex
	- .bib
	- .sty
	- figures
	- output files: .html, .pdf
	- files to reproduce the results presented: R scripts, data
	- motivating letter: why your paper is suitable for RJournal
	- if required: supplementary files for additional techinal details, examples

## Creating your article
- [rjtools](https://rjournal.github.io/rjtools/)
- recommendation:
	- using *create_article()* function
	- write without specific ref. to HTML or LaTeX codes
		- knitr::is_html_output()
		- knitr::is_latex_output()
- distill framework
	- styling and arrangement for the article content
	- [more info](https://rstudio.github.io/distill/)

## Checking your article
- built-in functions of the *rjtools* package
- initial_check_article()
	- check_wrapper() : if RJournal.tex and RJournal.pdf are present
	- check_filename()
	- etc.

## File format for submission
- Your name
- emali addresses for the corresponding author
- alternate email address
- names of all authors
- article title
- article type
- article keywords/tags: at least one or two
- zip file containing
	- files to build the article: .Rmd, .tex, .bib, .sty and figures
	- files to reproduce results: R scripts and data
	- motivating letter
	- reproducibility (supplemetary) files: to reproduce your reported results, additional technical details or extra examples
- a list of reproducibility and supplementary files: exactly as they are placed in your paper directory, to be entered comma-delimited like

	>  mypaper.Rmd, data/mydata.rds, scripts/mycode.R, appendix.pdf
	- the list will be used to build the .zip file that is distributed along with the paper as supplementary materials
	- it's possible to host on alternative site, if the zip is >10Mb
