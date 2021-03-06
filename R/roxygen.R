#' Use roxygen with markdown
#'
#' You'll need to manually re-document once enabled. If you are already using
#' roxygen2, but not with markdown, the [roxygen2md](https://github.com/r-lib/roxygen2md)
#' package will be used to convert many Rd expressions to markdown. The
#' package uses heuristics, so you'll need to check the results.
#'
#' @export
use_roxygen_md <- function() {
  check_installed("roxygen2")

  if (!uses_roxygen()) {
    roxy_ver <- as.character(utils::packageVersion("roxygen2"))

    use_description_field("Roxygen", "list(markdown = TRUE)")
    use_description_field("RoxygenNote", roxy_ver)
    ui_todo("Run {ui_code('devtools::document()')}")
  } else if (!uses_roxygen_md()) {
    check_installed("roxygen2md")
    if (!uses_git()) {
      ui_todo("Use git to ensure that you don't lose any data")
    }

    ui_todo("Run the following code, then rerun {ui_code('devtools::document()')}")
    ui_code_block("roxygen2md::roxygen2md(\"{proj_get()}\")")
  }

  invisible()
}

uses_roxygen_md <- function(base_path = proj_get()) {
  if (!desc::desc_has_fields("Roxygen", base_path)) {
    return(FALSE)
  }

  roxygen <- desc::desc_get("Roxygen", base_path)[[1]]
  value <- tryCatch(
    {
      eval(parse(text = roxygen))
    },
    error = function(e) {
      NULL
    }
  )

  isTRUE(value$markdown)
}

uses_roxygen <- function(base_path = proj_get()) {
  desc::desc_has_fields("RoxygenNote", base_path)
}

roxygen_ns_append <- function(tag) {
  block_append(
    glue("{ui_value(tag)}"),
    glue("#' {tag}"),
    path = proj_path(package_doc_path()),
    block_start = "## usethis namespace: start",
    block_end = "## usethis namespace: end",
    block_suffix = "NULL"
  )
}

roxygen_update <- function() {
  ui_todo("Run {ui_code('devtools::document()')} to update {ui_path('NAMESPACE')}")
  TRUE
}


# Checkers ----------------------------------------------------------------

check_uses_roxygen <- function(whos_asking) {
  force(whos_asking)

  if (uses_roxygen()) {
    return(invisible())
  }

  ui_stop(
    "
    Project {ui_value(project_name())} does not use roxygen2.
    {ui_code(whos_asking)} can not work without it.
    "
  )
}
