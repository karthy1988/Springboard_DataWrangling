library(dplyr)
library(tidyr)

#Load the data in RStudio
titanic <- read.csv("~/Documents/Springboard_Exercise/titanic_original.csv")

#Understand the structure of data
summary(titanic)

#Port of embarkation
titanic$embarked <- gsub(" ", "S", titanic$embarked)

#Age
avg <- mean(titanic$age, na.rm = TRUE)
titanic$age[titanic$age == NA] <- avg

#Lifeboat
titanic$boat[titanic$boat == ""] <- NA

#Cabin
titanic <- mutate(titanic, "has_cabin_number" = if_else(cabin == "", 0, 1))

#Submit the project on Github
write.csv(titanic, file = "titanic_clean.csv")



