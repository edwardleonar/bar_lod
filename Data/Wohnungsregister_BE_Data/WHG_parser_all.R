setwd("//bfhfilerbe01.bfh.ch/pue2/Documents/RDF/Data/Wohnungsregister_BE/")
library(readr)
library(readxl)
#Import all 3 datasets
#Coordinates were considered as characters because of the dot(.) decimal.

#Buildings
Table_GEB <- read_delim("/Table_GEB-01.txt", 
                        "\t", escape_double = FALSE, col_names = FALSE, 
                        col_types = cols(X24 = col_date(format = "%d.%m.%Y"), 
                                         X2 = col_character(), X24 = col_date(format = "%d.%m.%Y"), 
                                         X25 = col_date(format = "%d.%m.%Y"), 
                                         X7 = col_character(), X8 = col_character(),
                                         X3 = col_character()), trim_ws = TRUE)

#Apartments
Table_WHG <- read_delim("/Table_WHG-01.txt", 
                           "\t", escape_double = FALSE, col_names = FALSE,
                           col_types = cols(X10 = col_date(format = "%d.%m.%Y"),
                                            X9 = col_date(format = "%d.%m.%Y")), 
                           trim_ws = TRUE)


# 
Table_EIN_codes <- read_delim("/Table_EIN-01.txt", 
                             "\t", escape_double = FALSE, col_names = FALSE, 
                             col_types = cols(X10 = col_character(), 
                                              X12 = col_character(), X14 = col_character(), 
                                              X15 = col_character(), X16 = col_character(), 
                                              X17 = col_date(format = "%d.%m.%Y"), 
                                              X18 = col_date(format = "%d.%m.%Y"), 
                                              X2 = col_character()), locale = locale(), 
                             trim_ws = TRUE)

#Import labels for each dataset
labels_GEB <- read_excel("Maske-Masque_GEB-01.xlsx", 
                                        sheet = "Spezifikationen-Spécifications")
labels_WHG<- read_excel("Maske-Masque_WHG-01.xlsx", 
                        sheet = "Spezifikationen-Spécifications")
labels_EIN_codes <- read_excel("Maske-Masque_EIN-01.xlsx", 
                               sheet = "Spezifikationen-Spécifications")

# Assign proper column names to their respective tables
names(Table_GEB) <- labels_GEB$Abkürzung
names(Table_WHG) <- labels_WHG$Abkürzung
names(Table_EIN_codes) <- labels_EIN_codes$Abkürzung


# Save all tables into different CSV files
write.csv(Table_GEB, "Table_GEB.csv", row.names = FALSE)
write.csv(Table_WHG, "Table_WHG.csv", row.names = FALSE)
write.csv(Table_EIN_codes, "Table_EIN_codes.csv", row.names = FALSE)

## Missing file
#Lands
Table_GST <- read_delim("Table_GST-01.txt", 
                        "\t", escape_double = FALSE, col_names = FALSE, 
                        col_types = cols(X4 = col_character(),
                                         X5 = col_character(),
                                         X6 = col_character(),
                                         X7 = col_date(format = "%d.%m.%Y"),
                                         X8 = col_date(format = "%d.%m.%Y")),trim_ws = TRUE)
labels_GST <- read_excel("Maske-Masque_GST-01.xlsx", 
                               sheet = "Spezifikationen-Spécifications")
names(Table_GST) <- labels_GST$Abkürzung
write.csv(Table_GST, "Table_GST.csv", row.names = FALSE)
