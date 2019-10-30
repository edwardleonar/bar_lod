# Importing libraries
library(readxl)
library(data.table)
library(xts)
library(tidyverse)
library(stringr)

setwd("//bfhfilerbe01.bfh.ch/pue2/Documents/RDF/Data/Berufnomenklatur_international")
file_xls=("do-d-00-isco08-01.xlsx")

# Importing relevant excel sheet
data_occup <- read_excel(file_xls, 
    sheet = "ISCO-08, deutsche Fassung", 
    col_names = FALSE)

# Assigning the  names to the columns
names(data_occup) <- c("index", "name_occup_de")
# Remove unnecessary columns
data_occup <- data_occup[ -c(821:824), ]  #rows
data_occup$str_count <- nchar(data_occup$index)

# Assigning the official names to the columns
data_occup$Berufsabteilungen <- ifelse(data_occup$str_count == 1,
                                       data_occup$index, NA)
data_occup$Berufsklassen <- ifelse(data_occup$str_count == 2,
                                       data_occup$index, NA)
data_occup$Berufsgruppen <- ifelse(data_occup$str_count == 3,
                                   data_occup$index, NA)
data_occup$Berufsarten <- ifelse(data_occup$str_count == 4,
                                   data_occup$index, NA)
labels_data <- data_occup
# Add other languages labels

# Importing relevant excel sheet
data_occup_fr <- read_excel("do-f-00-isco08-01.xlsx", sheet = 2, col_names = FALSE)
data_occup_it <- read_excel("do-i-00-isco08-01.xlsx", sheet = 2, col_names = FALSE)
data_occup_en <- read_excel("do-e-00-isco08-01.xlsx", sheet = 2, col_names = FALSE)
data_occup_fr <- data_occup_fr[ -c(821:824), ]  #rows
data_occup_it <- data_occup_it[ -c(821:824), ]  #rows
data_occup_en <- data_occup_en[ -c(821:824), ]  #rows

# Adding labels in other languages
labels_data$name_occup_fr <- data_occup_fr$...2
labels_data$name_occup_it <- data_occup_it$...2
labels_data$name_occup_en <- data_occup_en$...2

# Remove unnecessary column & save label file
labels_data <- labels_data[ ,-c(3) ]  #column
write.csv(labels_data, "labels_data.csv", row.names = FALSE) 



# Assign the respective class to missing values

# Class_1
data_occup$Berufsabteilungen <- na.locf(data_occup$Berufsabteilungen)

#Class_2 Using Tidyverse
data_occup<- data_occup %>% group_by(Berufsabteilungen) %>%  fill(Berufsklassen)

#Class_3 using Regular expression by writing a function
# ^([^.]+)
data_occup$Berufsgruppen <-   ifelse(is.na(data_occup$Berufsgruppen),
                                     str_extract(data_occup$Berufsarten, "[0-9]{3}"),
                                     data_occup$Berufsgruppen)

# Adjust names to differentiate from previous xls file
data_occup <- data_occup[ ,-c(3) ]  #column
names(data_occup) <- c("index","name_occup_de", "class_1", "class_2", "class_3", "class_4")

# Saving the file to CSV
write.csv(data_occup, "data_occup_international.csv", row.names = FALSE) 
