% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rmarkdown.R
\name{use_rmarkdown_template}
\alias{use_rmarkdown_template}
\title{Add an RMarkdown Template}
\usage{
use_rmarkdown_template(template_name = "Template Name",
  template_dir = tolower(asciify(template_name)),
  template_description = "A description of the template",
  template_create_dir = FALSE)
}
\arguments{
\item{template_name}{The name as printed in the template menu.}

\item{template_dir}{Name of the directory the template will live in within
\code{inst/rmarkdown/templates}.}

\item{template_description}{Sets the value of \code{description} in
\code{template.yml}.}

\item{template_create_dir}{Sets the value of \code{create_dir} in \code{template.yml}.}
}
\description{
Adds files and directories necessary to add a custom rmarkdown template to
RStudio. It creates:
\itemize{
\item \code{inst/rmarkdown/templates/{{template_dir}}}. Main directory.
\item \code{skeleton/skeleton.Rmd}. Your template Rmd file.
\item \code{template.yml} with basic information filled in.
}
}
\examples{
\dontrun{
use_rmarkdown_template()
}
}
