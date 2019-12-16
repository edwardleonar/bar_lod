library(readxl)
library(stringr)
library(tidyr)

agglos   <- read_excel("//bfhfilerbe01.bfh.ch/pue2/Documents/RDF/Data/Agglomeration/su-d-21.03.01.01.xls", 
                               sheet = "liste_agglomerationen_kerne", 
                               na = "0", skip = 3)
# Remove subtotal and non-agglo rows
agglos <- agglos[ -c(1:3, 53:93), ]  #rows

# Create more machine-readable names
names(agglos) <- c("identifier", "Agglo_name", "nr_CH_gmd", "nr_non_CH_gmd",
                   "total_nr_gmd", "population_CH", "population_non_CH",
                   "total_population_2012")

# Clean up the Agglo identifier column
agglos$identifier <- str_extract(agglos$identifier, "[0-9]{1,5}")

# Saving the file to CSV
setwd("//bfhfilerbe01.bfh.ch/pue2/Documents/RDF/Data/Agglomeration/")
write.csv(agglos, "agglo_list.csv", row.names = F)


# Second Sheet
gmd_list <- read_excel("//bfhfilerbe01.bfh.ch/pue2/Documents/RDF/Data/Agglomeration/su-d-21.03.01.01.xls", 
                       sheet = "gemeinden_agglomerationen", 
                       skip = 3)

# Remove unnecessary columns
gmd_list <- gmd_list[ , -c(6,7,9) ]  #columns

# Create more machine-readable names
names(gmd_list) <- c("gmd_identifier", "gmd_name", "Land", "kanton","agglo_identifier",
                   "population_2012")

# Remove subtotal/NA rows 
# Delete subtotal rows
gmd_list<- gmd_list[complete.cases(gmd_list$agglo_identifier), ]

# Clean up the Agglo identifier column
gmd_list$agglo_identifier <- str_extract(gmd_list$agglo_identifier, "[0-9]{1,5}")

# Saving the file to CSV
write.csv(gmd_list, "gmd_agglo_list.csv", row.names = F)
