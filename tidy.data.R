install.packages("reshape2")
library(reshape2)
install.packages("plyr")
library(plyr)
install.packages("stringr")
library(stringr)


?melt
??melt

pew <- read.delim(file = "pew.txt")
str(pew)
names(pew)
pew.better <- melt(pew, id.vars="religion")

pew.dplyr <- pew %>% 
    gather(income, n, -religion)

###IF you want to melt on more than one column
#pew.better <- melt(pew, id.vars=c("religion", "X..10k"))

str(pew.better)
head(pew.better)
names(pew.better) <- c("religion", "income", "n")
head(pew.better)

##this didn't work
#revalue(pew.better$income, from=c("X..10k", "X.10.20k"), to = c("10k", "10_20k"))

raw <- read.csv("tb.csv", stringsAsFactors = FALSE)
head(raw)
raw$new_sp <- NULL
names(raw) <- str_replace(names(raw), "new_sp_", "")
head(raw)
melted <- melt(raw, id.vars = c("iso2", "year"))
str(melted)
?str_sub
melted$gender <- str_sub(melted$variable, start=1L, end=1L)
melted$age <- str_sub(melted$variable, start=2, -1)
melted$variable <- NULL
str(melted)

boxplot(melted$value ~ melted$age * melted$gender)
boxplot(log(melted$value) ~ melted$age * melted$gender)

boxplot(log(melted$value) ~ as.factor(melted$age))
