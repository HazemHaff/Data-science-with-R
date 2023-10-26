install.packages("httpuv")

library(httr)
library(jsonlite)

app_info <- oauth_app(
  "github",
  key ="*****************",
  secret ="***********************************"
)

access_token <- oauth2.0_token(oauth_endpoints("github"), app_info)


token_config <- config(token = access_token)
api_request <- GET("https://api.github.com/users/jtleek/repos", token_config)
stop_for_status(api_request)

#Extract and Parse Content.
api_content <- content(api_request, "parsed")

#Filter to find 'datasharing' Repository and its Creation Time.
datasharing_repo <- lapply(api_content, function(x) {
  if (x$name == "datasharing") {
    return(x)
  } else {return(NULL)}
})

#remove NULLss
datasharing_repo <- Filter(Negate(is.null), datasharing_repo)

#extract creation time if 'datasharing' repo exists.
if (length(datasharing_repo) > 0) {
  created_time <- datasharing_repo[[1]]$created_at
  print(paste("The 'datasharing' repository was created at:", created_time))
} else {print("The 'datasharing' repository was not found.")}