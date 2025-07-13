#' Call AI
#'
#' Sends a prompt to the Google's Gemma 3 12B model.
#' Requires a free OpenRouter API, which can be obtained on \href{https://openrouter.ai/}{the OpenRouter website}.
#'
#' @param input The prompt to be submitted to Gemma 3 12B
#'
#' @returns Gemma 3 12B's response to the submitted prompt
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' call_ai(
#' input = "How can I learn swimming?"
#' )
#' }
call_ai <- function(
    input
    ){

  if(!is.character(input) | nchar(input) == 0){
    stop("Invalid input")
  }

  if(!("openrouter_package_api" %in% names(Sys.getenv()))){
    Sys.setenv(openrouter_package_api = readline(
      "Please enter your OpenRouter API: "
    ))
  }

  library(httr)
  library(jsonlite)

  res <- POST(
    url = "https://openrouter.ai/api/v1/chat/completions",
    add_headers(
      Authorization = paste("Bearer", Sys.getenv("openrouter_package_api"))
    ),
    body = toJSON(list(
      model = "google/gemma-3-12b-it:free",
      messages = list(
        list(role = "user", content = input)
      )
    ), auto_unbox = TRUE),
    encode = "json"
  )

  cat(content(res)$choices[[1]]$message$content)
}

