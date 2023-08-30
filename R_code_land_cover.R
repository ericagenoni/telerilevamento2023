#LAND COVER

# Load the required packages (raster, ggplot2, patchwork)
library(raster)
library(ggplot2) # ggplot graphs
install.packages("patchwork")
library(patchwork) # To combine 2 ggplot graphs into the same graph

# Set working directory
setwd("C:/Data_telerilevamento/lab")

# Load data about deforestation
defor1 <- brick("defor1_.png") # 1992
defor2 <- brick("defor2_.png") # 2006

# NIR   = 1
# Red   = 2
# Green = 3

# Plot the images in a multiframe
par(mfrow=c(2, 1))
plotRGB(defor1, 1, 2, 3, stretch="lin")
plotRGB(defor2, 1, 2, 3, stretch="lin")
dev.off()



# CLASSIFICATION OF THE 1992 IMAGE

# 1. Get values
singlenr1 <- getValues(defor1)
singlenr1

# 2. Classify
kcluster1 <- kmeans(singlenr1, centers=2)
kcluster1

# 3. Recreating an image
defor1_class <- setValues(defor1[[1]], kcluster1$cluster)

# Plot the classified image
plot(defor1_class)





# CLASSIFICATION OF THE 2006 IMAGE

# 1. Get values
singlenr2 <- getValues(defor2)
singlenr2

# 2. Classify
kcluster2 <- kmeans(singlenr2, centers=2)
kcluster2

# 3. Recreating an image
defor2_class <- setValues(defor2[[1]], kcluster2$cluster)

# Plot the classified image
plot(defor2_class)





# Create a multiframe
par(mfrow=c(2, 1))
plot(defor1_class)
plot(defor2_class)





# Class percentage 1992
frequencies1 <- freq(defor1_class)
frequencies1

tot1 <- ncell(defor1_class)
tot1 # 341292

percentage1 <- (frequencies1*100)/tot1
percentage1

# Forest    = 89.74632%
# Bare soil = 10.25368%





# Class percentage 2006
frequencies2 <- freq(defor2_class)
frequencies2

tot2 <- ncell(defor2_class)
tot2 # 342726

percentage2 <- (frequencies2*100)/tot2
percentage2

# Forest    = 52.06958%
# Bare soil = 47.93042%





# Let's make a dataframe
cover <- c("Forest","Bare Soil")
perc_1992 <- c(89.75, 10.25)
perc_2006 <- c(52.07, 47.93)
percentages <- data.frame(cover, perc_1992, perc_2006)
percentages




# Plot using ggplot2
ggplot(percentages,
       aes(x=cover, y=perc_1992, color=cover)) +
       geom_bar(stat="identity",
                fill="white")
# we wanna know the IDENTITY for this kind of statistics, not the count

ggplot(percentages,
       aes(x=cover, y=perc_2006, color=cover)) +
       geom_bar(stat="identity",
                fill="white")

# Patchwork
p1 <- ggplot(percentages,
             aes(x=cover, y=perc_1992, color=cover)) +
             geom_bar(stat="identity",
                      fill="white") +
             ggtitle("1992")

p2 <- ggplot(percentages,
             aes(x=cover, y=perc_2006, color=cover)) +
             geom_bar(stat="identity",
                      fill="white") +
             ggtitle("2006")

# Let's put together p1 and p2
p1 + p2

# To standardize the y axes we use ylim() function
