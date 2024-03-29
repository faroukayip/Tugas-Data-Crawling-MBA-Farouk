# Title     : IMDB Web Scraping
# Objective : To scrap IMDb website for the 100 most popular feature films released in 2019. 
# Author    : Ayip Farouk
# Inspired by : Bernardus Ari Kuncoro

# Loading the rvest package
install.packages('rvest')
library(rvest)

#Specifying the url for desired website to be scraped
url <- 'https://www.imdb.com/search/title/?count=100&release_date=2019,2019&title_type=feature'

#Reading the HTML code from the website
webpage <- read_html(url)

# Here the list of columns are

# Rank: The rank of the film from 1 to 100 on the list of 100 most popular feature films released in 2016.
# Title: The title of the feature film.
# Description: The description of the feature film.
# Runtime: The duration of the feature film.
# Genre: The genre of the feature film,
# Rating: The IMDb rating of the feature film.
# Votes: Votes cast in favor of the feature film.
# Gross_Earning_in_Mil: The gross earnings of the feature film in millions.
# Director: The main director of the feature film. Note, in case of multiple directors, I’ll take only the first.
# Actor: The main actor of the feature film. Note, in case of multiple actors, I’ll take only the first.


#Using CSS selectors to scrap the rankings section
rank_data_html <- html_nodes(webpage,'.text-primary')

#Converting the ranking data to text
rank_data <- html_text(rank_data_html)

#Let's have a look at the rankings
head(rank_data)
length(rank_data)

#Data-Preprocessing: Converting rankings to numerical
rank_data<-as.numeric(rank_data)

#Let's have another look at the rankings
head(rank_data)

#Using CSS selectors to scrap the title section
title_data_html <- html_nodes(webpage,'.lister-item-header a')

#Converting the title data to text
title_data <- html_text(title_data_html)

#Title
head(title_data)
length(title_data)

#Using CSS selectors to scrap the description section
description_data_html <- html_nodes(webpage,'.text-muted+ .text-muted , .ratings-bar+ .text-muted')

#Converting the description data to text
description_data <- html_text(description_data_html)
length(description_data_html)
#description data
head(description_data)

#removing '\n'
description_data<-gsub("\n","",description_data)

#description data 
head(description_data)
length(description_data)

#Using CSS selectors to scrap the Movie runtime section
runtime_data_html <- html_nodes(webpage,'.text-muted .runtime')

#Converting the runtime data to text
runtime_data <- html_text(runtime_data_html)

#runtime
head(runtime_data)

#Data-Preprocessing: removing mins and converting it to numerical

runtime_data<-gsub(" min","",runtime_data)
runtime_data<-as.numeric(runtime_data)

#Let's have another look at the runtime data
head(runtime_data)


#Using CSS selectors to scrap the Movie genre section
genre_data_html <- html_nodes(webpage,'.genre')

#Converting the genre data to text
genre_data <- html_text(genre_data_html)

#Genre
head(genre_data)

#Data-Preprocessing: removing \n
genre_data<-gsub("\n","",genre_data)

#Data-Preprocessing: removing excess spaces
genre_data<-gsub(" ","",genre_data)

#taking only the first genre of each movie
genre_data<-gsub(",.*","",genre_data)

#Convering each genre from text to factor
genre_data<-as.factor(genre_data)

#genre data
head(genre_data)

#Using CSS selectors to scrap the IMDB rating section
rating_data_html <- html_nodes(webpage,'.ratings-imdb-rating strong')

#Converting the ratings data to text
rating_data <- html_text(rating_data_html)

#ratings
head(rating_data)

#Data-Preprocessing: converting ratings to numerical
rating_data<-as.numeric(rating_data)

#ratings data
head(rating_data)

#Using CSS selectors to scrap the votes section
votes_data_html <- html_nodes(webpage,'.sort-num_votes-visible span:nth-child(2)')

#Converting the votes data to text
votes_data <- html_text(votes_data_html)

#votes data
head(votes_data)

#Data-Preprocessing: removing commas
votes_data<-gsub(",","",votes_data)

#Data-Preprocessing: converting votes to numerical
votes_data<-as.numeric(votes_data)

#votes data
head(votes_data)
length(votes_data)

for (i in c(6,7,11,16,22,26,29,32,37,39,41,46,49,58,60,62,63,66,72,77,82,86,87,89,95,97)){
  a<-votes_data[1:(i-1)]
  b<-votes_data[i:length(votes_data)]
  votes_data<-append(a,list("NA"))
  votes_data<-append(votes_data,b)
}

#Data-Preprocessing: converting votes to numerical
votes_data<-as.numeric(votes_data)

#length of the metascore data
length(votes_data)

#summary statistics
summary(votes_data)

#Using CSS selectors to scrap the directors section
directors_data_html <- html_nodes(webpage,'.text-muted+ p a:nth-child(1)')

#Converting the directors data to text
directors_data <- html_text(directors_data_html)

#directors data
head(directors_data)

#Data-Preprocessing: converting directors data into factors
directors_data<-as.factor(directors_data)

#Using CSS selectors to scrap the actors section
actors_data_html <- html_nodes(webpage,'.lister-item-content .ghost+ a')

#Converting the gross actors data to text
actors_data <- html_text(actors_data_html)

#the actors data
head(actors_data)

#Data-Preprocessing: converting actors data into factors
actors_data<-as.factor(actors_data)

#Using CSS selectors to scrap the metascore section
metascore_data_html <- html_nodes(webpage,'.metascore')
 
#Converting the runtime data to text
metascore_data <- html_text(metascore_data_html)

#Head metascore 
head(metascore_data)

#Data-Preprocessing: removing extra space in metascore
metascore_data<-gsub(" ","",metascore_data)

#Lets check the length of metascore data
length(metascore_data)


for (i in c(6,7,11,16,22,26,29,32,37,39,41,42,45,46,49,52,58,60,62,63,64,66,72,77,79,82,86,87,89,94,95,97,98,99)){
  a<-metascore_data[1:(i-1)]
  b<-metascore_data[i:length(metascore_data)]
  metascore_data<-append(a,list("NA"))
  metascore_data<-append(metascore_data,b)
}

#Data-Preprocessing: converting metascore to numerical
metascore_data<-as.numeric(metascore_data)

#length of the metascore data
length(metascore_data)

#summary statistics
summary(metascore_data)

#Using CSS selectors to scrap the gross revenue section
gross_data_html <- html_nodes(webpage,'.ghost~ .text-muted+ span')

#Converting the gross revenue data to text
gross_data <- html_text(gross_data_html)

#Let's have a look at the votes data
head(gross_data)

#Data-Preprocessing: removing '$' and 'M' signs
gross_data<-gsub("M","",gross_data)

gross_data<-substring(gross_data,2,6)

#Let's check the length of gross data
length(gross_data)

#Filling missing entries with NA
for (i in c(6,7,11,12,13,16,22,24,26,29,32,37,39,41,42,45,46,49,50,52,58,60,62,63,66,71,72,73,74,75,77,79,80,81,82,83,84,86,87,89,94,95,96,97,98,99)){
  
  a<-gross_data[1:(i-1)]
  
  b<-gross_data[i:length(gross_data)]
  
  gross_data<-append(a,list("NA"))
  
  gross_data<-append(gross_data,b)
  
}

#Data-Preprocessing: converting gross to numerical
gross_data<-as.numeric(gross_data)

#Let's have another look at the length of gross data
length(gross_data)

summary(gross_data)

#Combining all the lists to form a data frame
movies_df<-data.frame(Rank = rank_data, Title = title_data,
                      Description = description_data,
                      Genre = genre_data,
                      Director = directors_data, Actor = actors_data, Metascore = metascore_data, Votes = votes_data)


#Structure of the data frame
str(movies_df)
write.csv(movies_df,"top100moviesIn2019.csv")
getwd()
