#' Call AI
#'
#' Sends a prompt to the Qwen 3 30B A3B LLM.
#' Requires a free OpenRouter API, which can be obtained on \href{https://openrouter.ai/}{the OpenRouter website}.
#'
#' @param input The prompt submitted to Qwen 3 30B A3B
#'
#' @returns Qwen 3 30B A3B's response to the submitted prompt
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' call_ai(
#' input = "How can I learn swimming?"
#' )
#' }
call_ai <- function(input){

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
      model = "qwen/qwen3-30b-a3b:free",
      messages = list(
        list(role = "user", content = input)
      )
    ), auto_unbox = TRUE),
    encode = "json"
  )

  cat(content(res)$choices[[1]]$message$content)
}

