#' Set API
#'
#' Sets the free OpenRouter API, which is necessary for the \code{\link{check_jailbreak}}
#' function and can be obtained on \href{https://openrouter.ai/}{the OpenRouter website}.
#'
#' @param api The API to be set. Has to be entered as a character string.
#'
#' @returns Nothing
#' @export
#'
#' @examples
#' \dontrun{
#' set_api(
#' api = "your_openrouter_api"
#' )
#' }
set_api <- function(
    api
    ){

  if(!is.character(api)){
    stop("The API has to be entered as a character string.")
  }

  Sys.setenv(openrouter_package_api = api)
}
