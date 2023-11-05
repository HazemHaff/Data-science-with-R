install.packages("jpeg")
library(jpeg)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg","jeff.jpg")

img_data<-readJPEG("jeff.jpg",native=TRUE)

quantiles<-quantile(img_data,probs=c(0.3, 0.8))

print(paste("30th quantile:",quantiles[1]))
print(paste("80th quantile:",quantiles[2]))
