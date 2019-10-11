###############################
# analysis script
#
#this script loads the processed, cleaned data, does a simple analysis
#and saves the results to the results folder

#load needed packages. make sure they are installed.
library(ggplot2)
library(dplyr)
library(broom)
library(ggbiplot)

#load data. path is relative to project directory.
CA09_mabs <- readRDS("./data/processed_data/CA09mabs_processed_data.rds")
CA09_sera <- readRDS("./data/processed_data/CA09sera_processed_data.rds")
p1_mabs <- readRDS("./data/processed_data/p1mabs_processed_data.rds")
p1_sera <- readRDS("./data/processed_data/p1sera_processed_data.rds")

#I need these because I wrote the code before I realized that my data wasn't actually linked. So I'll need to go back and clean this up.
CA09_mabs_full <- readRDS("./data/processed_data/CA09mabs_full_processed_data.rds")
CA09_sera_full <- readRDS("./data/processed_data/CA09sera_full_processed_data.rds")
p1_mabs_full <- readRDS("./data/processed_data/p1mabs_full_processed_data.rds")
p1_sera_full <- readRDS("./data/processed_data/p1sera_full_processed_data.rds")

#take a look at the data
glimpse(CA09_mabs)
glimpse(CA09_sera)
glimpse(p1_mabs)
glimpse(p1_sera)



CA09_mabs <- CA09_mabs %>%
  group_by(monoclonal) %>%
  arrange(concentration)
  
  
#Example graph to try and get the range of reaction of the monoclonal antibodies. 
d <- CA09_mabs %>%
  filter(monoclonal == "1E6") %>%
  ggplot(aes(y = 1/concentration, x = antigen)) +
  geom_point() +
  scale_y_continuous(trans='log2') +
  theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
  labs(y = "Inverse Concentration")

#Graph of all the monoclonal responses
CA09_monoclonal_responses <- CA09_mabs %>%
  ggplot(aes(y = 1/concentration, x = antigen, color = lineage)) +
  geom_point() +
  scale_y_continuous(trans='log2') +
  theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
  labs(y = "Inverse Concentration") +
  facet_wrap(vars(monoclonal), scales = "free_x")

ggsave(filename="./results/resultfigure1.png", plot = CA09_monoclonal_responses)

p1_monoclonal_responses <- p1_mabs %>%
  ggplot(aes(y = 1/concentration, x = antigen, color = lineage)) +
  geom_point() +
  scale_y_continuous(trans='log2') +
  theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
  labs(y = "Inverse Concentration") +
  facet_wrap(vars(monoclonal), scales = "free_x")

ggsave(filename="./results/resultfigure2.png", plot = p1_monoclonal_responses)

p1_sera_responses <- p1_sera %>%
  ggplot(aes(y = titer, x = antigen, color = lineage, alpha = 0.5)) +
  geom_point() +
  scale_y_continuous(trans='log2') +
  theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
  labs(y = "Inverse Concentration")

ggsave(filename="./results/resultfigure3.png", plot = p1_sera_responses)

CA09_sera_responses <- CA09_sera %>%
  ggplot(aes(y = titer, x = antigen, color = lineage, alpha = 0.5)) +
  geom_point() +
  scale_y_continuous(trans='log2') +
  theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
  labs(y = "Inverse Concentration")

ggsave(filename="./results/resultfigure4.png", plot = CA09_sera_responses)


#graph <- function(x) {
#CA09_mabs %>%
 # group_by(monoclonal == x) %>%
#  ggplot(aes(y = 1/concentration, x = reorder(antigen, geo_mean_CA09$geo_mean))) +
  #geom_point() +
#  scale_y_continuous(trans='log2') +
#  theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
 # labs(y = "Inverse Concentration")
#}
#This was my attempt to make a function that plotted everything. 
CAmabs <- unique(CA09_mabs$monoclonal)

for (i in CAmabs) {
 d <- CA09_mabs %>%
    filter(monoclonal == i) %>%
    ggplot(aes(y = 1/concentration, x = reorder(antigen, geo_mean_CA09$geo_mean))) +
    geom_point() +
    scale_y_continuous(trans='log2', limits = (20)) +
    theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
    labs(y = "Inverse Concentration", title = i)
}


#Principal component analysis on antibody responses to different viruses
#Need to remove all the mice that do not have full matrix
p1_sera_full <- p1_sera_full %>%
  select(-c(4:7, 13:14, 16:17)) %>%
  filter(mouse != 2 & mouse != 10)

#Need to remove mice that do not have variability ofr a virus. 
p1_sera_full_f <- p1_sera_full[,apply(p1_sera_full, 2, var, na.rm=TRUE) != 0]

#now can do pca analysis
p1_sera_full.pca <- prcomp(p1_sera_full_f, center = TRUE, scale = TRUE)
summary(p1_sera_full.pca)
str(p1_sera_full.pca)

p1_sera_pca_variance <- plot(p1_sera_full.pca, type = "l")

ggsave(filename="./results/resultfigure5.png", plot = p1_sera_pca_variance)

g <- ggbiplot(p1_sera_full.pca, obs.scale = 1, var.scale = 1, groups = p1_sera_full_f$mouse)

ggsave(filename="./results/resultfigure6.png", plot = g)

#Repeat with CA09_sera
#Need to remove all the mice that do not have full matrix
CA09_sera_full_f <- CA09_sera_full %>%
  select(-c(4:7, 13:14, 16:17))

#Need to remove mice that do not have variability for a virus. 
CA09_sera_full_f <- CA09_sera_full_f[,apply(CA09_sera_full_f, 2, var, na.rm=TRUE) != 0]

#now can do pca analysis
CA09_sera_full.pca <- prcomp(CA09_sera_full_f, center = TRUE, scale = TRUE)
summary(CA09_sera_full.pca)
str(CA09_sera_full.pca)

CA09_sera_pca_variance <- plot(CA09_sera_full.pca, type = "l")

ggsave(filename="./results/resultfigure7.png", plot = CA09_sera_pca_variance)

h <- ggbiplot(CA09_sera_full.pca, obs.scale = 1, var.scale = 1, groups = CA09_sera_full_f$mouse)
  
ggsave(filename="./results/resultfigure8.png", plot = h)



#There's not much variation, but if we add together the CA09_sera maybe we can see a little more variation
CA09_sera_full <- CA09_sera_full %>%
  select(-c(4:7, 13:14, 16:17))
#renumber p1 mice so they don't overlap with the CA09 mice ids
p1_sera_full$mouse <- c(7:14)

sera_full <- bind_rows("CA09" = CA09_sera_full, "P1" = p1_sera_full, .id = "groups")
#ok now that we have them all together and all the NAs are gone, we now need to get rid of the columns that have no variation.
sera_full_f <- sera_full%>%
  select(-c(1:2, 9:12))

sera_full.pca <- prcomp(sera_full_f, center = TRUE, scale = TRUE)
summary(sera_full.pca)
str(p1_sera_full.pca)

sera_pca_variance <- plot(sera_full.pca, type = "l")

i <- ggbiplot(sera_full.pca, obs.scale = 1, var.scale = 1, groups = sera_full$groups, labels = sera_full$mouse)

ggsave(filename="./results/resultfigure9.png", plot = i)

#The plot above is also known as variable correlation plots. It shows the relationships between all variables. It can be interpreted as follow:

#Positively correlated variables are grouped together.
#egatively correlated variables are positioned on opposite sides of the plot origin (opposed quadrants).
#The distance between variables and the origin measures the quality of the variables on the factor map. Variables that are away from the origin are well represented on the factor map.

#I want to try this for the monoclonals now too.

CA09_mabs_full <- CA09_mabs_full %>%
  select(-17) %>%
  na.omit()

CA09_mabs_full <- as.numeric(as.factor(CA09_mabs_full$monoclonal))
  

#Need to remove mice that do not have variability ofr a virus. 
CA09_mabs_full_f <- CA09_mabs_full[,apply(CA09_mabs_full, 2, var, na.rm=TRUE) != 0]

#now can do pca analysis
CA09_mabs_full.pca <- prcomp(CA09_mabs_full_f, center = TRUE, scale = TRUE)
summary(CA09_mabs_full.pca)
str(CA09_mabs_full.pca)

CA09_mabs_pca_variance <- plot(CA09_mabs_full.pca, type = "l")

ggsave(filename="./results/resultfigure5.png", plot = p1_sera_pca_variance)

#renumber p1 mice so they don't overlap with the CA09 mice ids
p1_sera_full$mouse <- c(7:14)

  