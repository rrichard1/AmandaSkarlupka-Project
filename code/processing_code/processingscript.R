###############################
# processing script

library(readxl)
P1_Mabs <- read_excel("data/raw_data/P1 Mabs.xlsx", 
                      sheet = "P1 Mabs")
CA09_Mabs <- read_excel("data/raw_data/P1 Mabs.xlsx", 
                      sheet = "CA09 Mabs")
P1_Sera <- read_excel("data/raw_data/P1 Mabs.xlsx", 
                        sheet = "P1 Sera")
CA09_Sera <- read_excel("data/raw_data/P1 Mabs.xlsx", 
                        sheet = "CA09 Sera")

summary(P1_Mabs)
summary(CA09_Mabs)
summary(P1_Sera)
summary(CA09_Sera)