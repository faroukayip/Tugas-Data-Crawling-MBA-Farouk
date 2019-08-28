# Title     : Twitter API Scraping
# Objective : To Scrap Twitter with API
# Author    : Ayip Farouk

# Step 1: Install and load rtweet package 

install.packages("rtweet")
library(rtweet)

install.packages("devtools")
library(devtools)

install_github("mkearney/rtweet")
library(rtweet)

# Step 2: API Authorization 

#access token / secret
token <- create_token(
  consumer_key = "sc6twzIfpKFyZnL1hHpg2xXne",
  consumer_secret = "ValNfu3BvLfrfUtTx7T6lgB7NyN5KnKZYZcxQvytUr3gHaDRcL",
  access_token = "41767898-yJTyHv9zrn4cjJVkjE711Y8LkKbCxSePTc6lvT399",
  access_secret = "z1lhpSslKKvZ8k88BqlFrlFkNI4heGfquflUGk2alaKOr")

# Step 3: Crawling Data Twitter 

#Define twitter username 

my_username='ayipfarouk'


# find 1000 tweets with keywords: "BUBARKANBANSER"

tweet <- search_tweets(q = "BUBARKANBANSER", n = 1000)

#column names of tweet 

colnames(tweet)
dim(tweet)

#three columns

k <- tweet[,c("created_at", "screen_name", "text")]

#Print k
print(k)

#export to csv
write.csv(k, "banser.txt")




