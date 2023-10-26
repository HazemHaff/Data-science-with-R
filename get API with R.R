library(httr)

#define OAuth Endpoints
oauth_platform <- oauth_endpoints("github")

#set Up OAuth App (Replace with your own credentials)
app_info <- oauth_app(
  "github",
  key = "API key",
  secret = "secret key"
)

#retrieve OAuth token
access_token <- oauth2.0_token(oauth_platform, app_info)

#configure token
token_config <- config(token = access_token)

#make an authenticated API request (exmpl: fetch user details)
api_request <- GET("https://api.github.com/user", token_config)

#check HTTP status
stop_for_status(api_request)

#extract and use Content
api_content <- content(api_request)

#display content
print(api_content)