#BEFORE WE START, I HIGHLY RECOMMEND THAT YOU TAKE THE Data Analytics in the Pulbic Sector Specialization
#From Michigan University,

#The Data was Provided By Michigan University as an educational Material,
#I wanted to make this Repo and Series of (Advanced Data Science w R)
#So I can first share what I learn, Second is to document new consepts and ideas
#Third Is to streamline my workflow,

#As I keep learning I discover something new everytime, and this Repo Can be of help
#for you too,

#Please be mindful of the the Data, as I do not own it.
#As for my code, you are free to use it,
#If you are interested in the topic in deep, Please I highly recommend
#To check the specialization program I mentioned above

#I also Recommend that you read:
#https://vita.had.co.nz/papers/layered-grammar.pdf
#https://ggplot2-book.org/




#This section specifically delves into the manipulation and understanding of categorical data in R,
#utilizing a dataset on Seattle Pet Licenses. We'll be exploring how to convert data types to categorical,
#or as they are known in R, factors. This is crucial for effective data visualization and analysis,
#especially when working with tools like ggplot2 and the tidyverse package.


#Converting Data types to categorial/Discrete (Factor) for Visualization Example:
#A factor is a specific type of data object used to categorize the data. 
#It's used to store categorical data and is especially important in statistical modeling and graphics.

library(dplyr)
library(tidyverse)
data <-read.csv("C:/Users/hhaff/Downloads/Seattle_Pet_Licenses.csv")
data

#Grouping by Zip codes(This way we can see how many Zip Code we have)
data |>
  group_by(ZIP.Code) |>
  summarize(total=n()) |>
  arrange(desc(total))

#We have 198 Zip code, We wont forget the NA values,
#In this specific case we will leave them in their category.

#In data analytics we often classify variables into either Discrete or Continuous.
#We also refer to discrete variables as Categories, sort of lables on buckets
#In R, these kins of variables are called Factors, they are Important with ggplot and the tidyverse.


#In our data, there is a species column, thats a perfect example of a factor,
#at the moment its encoded as character vector,
#If we check for unique entries we see there four species of aniamls,

#we convert this column into a factor
data$Species <- as.factor(data$Species)
data
str(data)
#Now we see that the Species column has been converted to factor type
#R actually converts it into an integer vector and creates a mapping between the numbers and the different categories
#we call these levels in R and adds it to the vector metadata.
#Hence OBJECT ORIENTED PROGRAMMING, Although R is not exclusively OOP.

#We can see if we use the `attributes()` function
attributes(data$Species)
head(data$Species)

#In this example there is no ordering to the factor
#These are just four different buckets
#But lets change this to an ordinal factor anyway

data$Species <- factor(data$Species,levels=c("Cat","Goat","Pig","Dog"),ordered=TRUE)
head(data$Species)

#We see now that the ordinal nature of this factor is encoded in the levels.
#This will allow us to do some comparisons between itesm in the buckets.


#Lets take the first cat and dog out of the dataset,
#one way is we use Slice function
first_dog <- data |> filter(Species=="Dog") |> slice(1)
first_cat <- data |> filter(Species=="Cat") |> slice(1)
#Lets compare their intelligence
first_dog$Species > first_cat$Species
#TRUE, that means dogs are smarter than cats!?



#Now this is the base R factor object, tidyverse expands the functions we can use,
#There is a whole Package devoted to working with factors called forecats

#We'll start with fct-recode

#Lets bucket cats and dogs into their own ones, and the rest in Other Critters
data$Species <- data$Species |> fct_recode("Other Critters" = "Goat","Other Critters"="Pig")
data

#Now we can see that the Goat and Pig buckets are collapsed, but the order stays true
#Warning, this has changed the underlying data, not just mapping, pigs and goats dont exist anymore
#now we have cats, dogs, and other critters


#Now the most common thing we'll do with factors in ggplot is to rearrange their order for display.
#We can use fct_relevel to do so,
#We want to represent this factor as the amount of trouble animals would normally
#get in, we would probably want dogs to be the smallest, then other critters,
#then cats,
data$Species <- data$Species |> fct_relevel("Dog","Other Critters","Cat")
head(data$Species)

#We might also want to organize our data alphabetically, we could pass in a sorting function
data$Species <- data$Species |> fct_relevel(sort)
print(head(data$Species))

#We can reverse the order
data$Species <- data$Species |> fct_relevel(rev)
print(head(data$Species))


#Now, Lets say we want to calculate how many of each pet exist in our dataset,
#We use factor ordering function, 
#the fct_reorder will allow us to reorder factors by another variable

#first we will create a new column in the dataset which is the frequency by which
#the given animal appears
data <- data |>
  group_by(Species) |>
  mutate(frequency=n())

#now we can change the ordering of the levels using our new fct_reorder function
data$Species <- fct_reorder(data$Species, data$frequency)
head(data$Species)

#Let's just send this in to factor() to set the order correctly
data$Species <- fct_reorder(data$Species, data$frequency) |> factor(ordered=TRUE)
head(data$Species)


#Now sorting by frequency is a super common need
#`forcats` has a specific function to sort by frequency, call `fct_infreq()`
data$Species <- data$Species |> fct_infreq()
head(data$Species)

# We can use fct_infreq which will sort them by frequency, from *largest* to
# smallest, and wipe out the ordering
data$Species <- data$Species |> fct_infreq(ordered = FALSE)
head(data$Species)




#In this segment, we focused on the concept of factors in R, 
#a key element for categorizing data and essential in statistical modeling and graphics. 
#We started by loading and exploring the Seattle Pet Licenses dataset, 
#where we identified and grouped data by ZIP codes, noting the presence of NA values.

#A critical part of this exploration was understanding the distinction between discrete (categorical) and continuous variables. 
#In R, categorical variables are managed as factors. We converted the 'Species' column from a character vector to a factor, 
#demonstrating how R internally handles factors by mapping them to an integer vector. 
#This conversion plays a significant role in object-oriented programming approaches in R.

#Further, we experimented with different functionalities provided by R and the tidyverse packages, 
#such as fct_recode, fct_relevel, and fct_infreq, to manipulate the factor levels for better data analysis and visualization. 
#These functions allowed us to reorder, collapse, and sort the factor levels based on various criteria like alphabetical order or frequency of occurrence.
