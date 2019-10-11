library(dslabs)
data(mtcars)
view(mtcars)

as_tibble(mtcars)

mtcars.pca <- prcomp(mtcars[, c(1:7, 10, 11)], center = TRUE, scale. = TRUE)
summary(mtcars.pca)
str(mtcars.pca)

library(ggbiplot)
ggbiplot(mtcars.pca)

ggbiplot(mtcars.pca, labels = rownames(mtcars))
