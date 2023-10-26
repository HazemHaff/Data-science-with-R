library(httr)

response <- GET("http://biostat.jhsph.edu/~jleek/contact.html")

#Parsing.
html_text <- content(response, as = "text")

#Spliting the content into lines.
html_lines <- strsplit(html_text, "\n")[[1]]

nchar_10th <- nchar(html_lines[10])
nchar_20th <- nchar(html_lines[20])
nchar_30th <- nchar(html_lines[30])
nchar_100th <- nchar(html_lines[100])

print(paste("N chars in 10th line: ", nchar_10th))
print(paste("N chars in 20th line: ", nchar_20th))
print(paste("N chars in 30th line: ", nchar_30th))
print(paste("N chars in 100th line: ", nchar_100th))