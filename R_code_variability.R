#VARIABILITY

# Load the required packages
library(raster)
library(ggplot2)
library(patchwork)
install.packages("viridis")
library(viridis)

# Set the working directory
setwd("C:/Data_telerilevamento/lab")

# Import the image "similaun.png" from Sentinel satellite
sen <- brick("sentinel.png")
ncell(sen) # 633612

# Plot the image
plot(sen)
plotRGB(sen, 1, 2, 3, stretch="lin")

# NIR   = 1
# Red   = 2
# Green = 3

# NIR on g component
plotRGB(sen, 2, 1, 3, stretch="lin")

# Calculate the variability over NIR
nir <- sen[[1]]
mean3 <- focal(nir, matrix(1/9, 3, 3), fun=mean)
# Calculate focal values for the neightborhood of focal cells using a matrix of
# weights, perhaps in combination with a function, mean() in this case
plot(mean3)

sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)
plot(sd3)

# Create a dataframe
sd3_d <- as.data.frame(sd3, xy=T)

# Plot the dataframe with ggplot2
ggplot() +
  geom_raster(sd3_d,
              mapping=aes(x=x, y=y, fill=layer))

# Plot the dataframe with viridis
ggplot() +
  geom_raster(sd3_d,
              mapping=aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis()

# Cividis (colour palette)
p1 <- ggplot() +
      geom_raster(sd3_d,
                  mapping=aes(x=x, y=y, fill=layer)) +
      scale_fill_viridis(option="cividis")

# Magma (colour palette)
ggplot() +
geom_raster(sd3_d,
            mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="magma")

# Adding a title
p2 <- ggplot() +
      geom_raster(sd3_d,
                  mapping=aes(x=x, y=y, fill=layer)) +
      scale_fill_viridis(option="magma") +
      ggtitle("Standard Deviation Via The Magma Colour Scale")

p1 + p2





# Create a multiframe with patchwork

# Viridis
p1 <- ggplot() +
      geom_raster(sd3_d,
                  mapping=aes(x=x, y=y, fill=layer)) +
      scale_fill_viridis() +
      ggtitle("Standard Deviation Via The Viridis Colour Scale")

# Inferno
p2 <- ggplot() +
      geom_raster(sd3_d,
                  mapping=aes(x=x, y=y, fill=layer)) +
      scale_fill_viridis(option="inferno") +
      ggtitle("Standard Deviation Via The Inferno Colour Scale")

p1 + p2





# EXERCISE: Plot the original image (nir) and its standard deviation
nir_d <- as.data.frame(nir, xy=T)

p3 <- ggplot() +
      geom_raster(nir_d,
                  mapping=aes(x=x, y=y, fill=sentinel_1)) +
      scale_fill_viridis(option="cividis") +
      ggtitle("NIR Via The Viridis Colour Scale")

p3 + p1
