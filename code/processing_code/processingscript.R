###############################
# processing script
#load the packages needed
library(readxl)
library(knitr)
library(tidyverse)
library(readxl)
library(gtools)
library(gdata)

#load the data. The data is contained within one excel file, but is separated on different sheets
p1_mabs_full <- read_excel("data/raw_data/P1 Mabs.xlsx", 
                      sheet = "P1 Mabs")
CA09_mabs_full <- read_excel("data/raw_data/P1 Mabs.xlsx", 
                      sheet = "CA09 Mabs")
p1_sera_full <- read_excel("data/raw_data/P1 Mabs.xlsx", 
                        sheet = "P1 Sera")
CA09_sera_full <- read_excel("data/raw_data/P1 Mabs.xlsx", 
                        sheet = "CA09 Sera")

#Take a look at the data and make sure that it loaded correctly
summary(p1_mabs_full)
str(p1_mabs_full)
summary(CA09_mabs_full)
str(CA09_mabs_full)
summary(p1_sera_full)
str(p1_sera_full)
summary(CA09_sera_full)
str(CA09_sera_full)

#Move the monoclonal antibody concentrations and the sera titers into the same column
p1_mabs <- p1_mabs_full %>%
  gather(key = "antigen", value = "concentration", 2:20)

CA09_mabs <- CA09_mabs_full %>%
  gather(key = "antigen", value = "concentration", 2:20)

p1_sera <- p1_sera_full %>%
  gather(key = "antigen", value = "titer", 2:20)

CA09_sera <- CA09_sera_full %>%
  gather(key = "antigen", value = "titer", 2:20)

#The sera was not ran against all the viruses due to a limited supply. So the viruses that were used for sera testing are filtered below.
CA09_sera <- CA09_sera %>%
  na.omit()
p1_sera <- p1_sera %>%
  na.omit()

#The concentrations are in two fold dilutions, the titers will be log2(value)
p1_mabs$log2 <- log2(p1_mabs$concentration)

CA09_mabs$log2 <- log2(CA09_mabs$concentration)

p1_sera$log2 <- log2(p1_sera$titer)

CA09_sera$log2 <- log2(CA09_sera$titer)

#The lineages of the viruses need to be added

antigen <- unique(CA09_mabs$antigen)
lineage <- c("Eurasian", "Eurasian", "Classical", "Classical", "Classical", "Classical",
             "Classical", "Classical", "Classical", "Classical", "Classical", "Human Seasonal",
             "Human Seasonal", "Human Seasonal", "Human Seasonal", "Classical", "Classical", "Classical",
             "Human Seasonal")

lineage_key <- tibble(antigen, lineage)

CA09_mabs <- left_join(CA09_mabs, lineage_key, by = "antigen")

CA09_sera <- left_join(CA09_sera, lineage_key, by = "antigen")

p1_mabs <- left_join(p1_mabs, lineage_key, by = "antigen")

p1_sera <- left_join(p1_sera, lineage_key, by = "antigen")

#save data as RDS
saveRDS(CA09_mabs, file = "./data/processed_data/CA09mabs_processed_data.rds")
saveRDS(CA09_sera, file = "./data/processed_data/CA09sera_processed_data.rds")
saveRDS(p1_mabs, file = "./data/processed_data/p1mabs_processed_data.rds")
saveRDS(p1_sera, file = "./data/processed_data/p1sera_processed_data.rds")
saveRDS(p1_sera_full, file = "./data/processed_data/p1sera_full_processed_data.rds")
saveRDS(CA09_sera_full, file = "./data/processed_data/CA09sera_full_processed_data.rds")
saveRDS(p1_mabs_full, file = "./data/processed_data/p1mabs_full_processed_data.rds")
saveRDS(CA09_mabs_full, file = "./data/processed_data/CA09mabs_full_processed_data.rds")

