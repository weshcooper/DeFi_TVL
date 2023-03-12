install.packages("car", dependencies=TRUE)
install.packages("ggthemes")
library(httr)
library(jsonlite)
library(dplyr)
library(ggplot2)
library(tidyverse)
library(gapminder) 
library(ggthemes)
library(car)

#Gathering data from DefiLlama API
res = GET("https://api.llama.fi/protocols")

#rawToChar(res$content)

data = fromJSON(rawToChar(res$content))

names(data)

#Selecting columns for main data frame

ProtocolTVL <- select(data, id, name, symbol, category, chain, tvl, mcap)

#Developing new data frames by amount of TVL
#Greater than a billion, Greater than a million
greaterBillion <- filter(ProtocolTVL, tvl >= 1000000000)
greaterMillion <- filter(ProtocolTVL, tvl < 1000000000, tvl >= 1000000)
greaterThousand <- filter(ProtocolTVL, tvl < 1000000, tvl >= 1000)
greater0 <- filter(ProtocolTVL, tvl <1000, tvl >= 0)

#groupedcat <- group_by(ProtocolTVL, category)

#Create data frame that contains count of category from main data frame
TVLcount <- count(ProtocolTVL, category)

TVLcountS <- TVLcount[order(TVLcount$n, decreasing=TRUE), ]

TVLcountS %>%
  
  topCat <- TVLcount %>% 
  top_n(5, n) %>%
  ggplot(aes(fct_rev(fct_reorder(category, n)), n)) +
  geom_col() +
  labs(x = "Use Case", 
       y = "Total Number of Protocals", 
       title = "Top 5 Use Cases for All Protocals",
       caption = "Source: DefiLlama") +
  geom_text(aes(label=n), vjust = -.3)

topCat + theme_polsara()


TVLseperated <- data.frame(labels = c(">= $1B", "More than & equal to $1M, less than $1B", "More than & equal to $1T, less than $1M", "More than & equal to $0, less than $1T"),
                           count = c(nrow(greaterBillion),nrow(greaterMilion),nrow(greaterThousand),nrow(greater0)))

TVLseperated %>%
  ggplot(aes(labels, count)) +
  geom_col()



###Looking at association between top 5 use cases and tvl
### First manipulate data, then stratify sample, then anova
mainTop5 <- filter(ProtocolTVL, tvl > 0, category == "Dexes" | category == "Yield" | category == "Lending" | category == "Reserve Currency" | category == "Algo-Stables" )


stratified <- mainTop5 %>%
  group_by(category) %>%
  sample_n(size=30)

#boxplot(tvl ~ category, data = mainTop5)


#anova
aov(tvl ~ category, data = mainTop5)

Anova(lm(tvl ~ chain * category, data=stratified))

Anova(lm(tvl ~ category * category, data=mainTop5))

one.way


####
write.csv(mainTop5, "\\cloud\\project\\TVLtop5categories.csv", row.names=TRUE)

