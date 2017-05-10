library(dplyr)
library(tidyr)
library(stringr)

refine <- read.csv("~/Desktop/R/refine_original.csv")

#Apply lowercase to all company names 
refine$company <- tolower(refine$company)

#Clean up brand names
refine$company <- gsub("phillips|philips|phllips|phillps|fillips|phlips", "philips", refine$company)
refine$company <- gsub("akz0|ak zo", "akzo", refine$company)
refine$company <- gsub("unilver", "unilever", refine$company)

#Separate product code and number
refine <- separate(refine, Product.code...number, c("product.code", "number"), sep="-")

#Add product categories
refine <- mutate(refine, product.categories = product.code)
refine$product.categories <- sub("p", "Smartphone", refine$product.categories)
refine$product.categories <- sub("v", "TV", refine$product.categories)
refine$product.categories <- sub("x", "Laptop", refine$product.categories)
refine$product.categories <- sub("q", "Tablet", refine$product.categories)

#Add full address for geocoding
refine <- unite(refine, full_address, address, city, country, sep="-")

#Create dummy variables for company and product category
library(dummies)

dummy.company <- dummy.data.frame(refine, dummy.class = "binary", names = "company", sep = "_")
dummy.product.categories <- dummy.data.frame(refine, dummy.class = "binary", names = "product.category", sep = "_")

#Convert resulting table to CSV file
write.csv(refine, "refine_clean.csv")