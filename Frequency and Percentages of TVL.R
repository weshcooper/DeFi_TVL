##### Analyzing TVLs greater than one billion
ChainCountBillion <- greaterBillion %>%
  count(chain)


ChainCountBillion <- mutate(ChainCountBillion, 
                            percentage = (n/sum(n))*100
)

##### Analyzing TVLs greater than one billion
ChainCountMillion <- greaterMillion %>%
  count(chain)


ChainCountMillion <- mutate(ChainCountMillion, 
                            percentage = (n/sum(n))*100
)