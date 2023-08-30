# LiDAR - 3D in R

# LiDAR is a method for determining ranges by targeting an object oa a surface
# with a laser and measuring the time for the reflected light to return to the
# receiver. It may scan multiple directions resulting in a 3D image

# Load the required packages
library(raster) # Geographic Data Dnalysis and Modelling
library(rgdal) # Geospatial Data Abstraction Library
library(viridis)
library(ggplot2)
library(patchwork)

# Set the working directory
setwd("C:/Data_telerilevamento/lab/dati")





# 2013

# Load data: Digital Surface Model 2013
dsm_2013 <- raster("2013Elevation_DigitalElevationModel-0.5m.tif")

# Visualize info about the loaded data
dsm_2013

# Plot DSM 2013
plot(dsm_2013, main="LiDAR Digital Surface Model San Genesio/Jenesien")



# Load data: Digital Terrain Models 2013
dtm_2013 <- raster("2013Elevation_DigitalTerrainModel-0.5m.tif")

# Visualize info about the loaded data
dtm_2013

# Plot DTM 2013
plot(dtm_2013, main="LiDAR Digital Terrain Model San Genesio/Jenesien")



# Create CHM 2013 as difference between DSM and DTM
chm_2013 <- dsm_2013 - dtm_2013

# Visualize info about CHM
chm_2013

# Coerce CHM 2013 into a dataframe
chm_2013_df <- as.data.frame(chm_2013, xy=T)

# Plot CHM with ggplot()
ggplot() +
  geom_raster(chm_2013_df,
              mapping=aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis() +
  ggtitle("CHM 2013 San Genesio/Jenesien")

# Save CHM 2013 on PC
writeRaster(chm_2013, "CHM_2013_San_Genesio/Jenesien.tif")





# 2004

# Load data: Digital Surface Model 2004
dsm_2004 <- raster("2004Elevation_DigitalElevationModel-2.5m.tif")

# Visualize info about the loaded data
dsm_2004

# Plot DSM 2004
plot(dsm_2004, main="LiDAR Digital Surface Model San Genesio/Jenesien")



# Load data: Digital Terrain Models 2004
dtm_2004 <- raster("2004Elevation_DigitalTerrainModel-2.5m.tif")

# Visualize info about the loaded data
dtm_2004

# Plot DTM 2004
plot(dtm_2013, main="LiDAR Digital Terrain Model San Genesio/Jenesien")



# Create CHM 2004 as difference between DSM and DTM
chm_2004 <- dsm_2004 - dtm_2004

# Visualize info about CHM
chm_2004

# Coerce CHM 2004 into a dataframe
chm_2004_df <- as.data.frame(chm_2004, xy=T)

# Plot CHM with ggplot()
ggplot() +
  geom_raster(chm_2004_df,
              mapping=aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis() +
  ggtitle("CHM 2004 San Genesio/Jenesien")

# Save CHM 2004 on PC
writeRaster(chm_2004, "CHM_2004_San_Genesio/Jenesien.tif")





# Difference between CHM
difference <- chm_2013 - chm_2004 # ERROR

# Resample 2013 to 2004 (2.5 m)
chm_2013_rs <- resample(chm_2013, chm_2004)

# Difference between CHM
difference <- chm_2013_rs - chm_2004

# Coerce the difference into a dataframe
difference_df <- as.data.frame(difference, xy=T)

# Plot the difference between CHM
ggplot() +
  geom_raster(difference_df,
              mapping=aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis() +
  ggtitle("Difference CHM San Genasio/Jenesien")

# Save CHM 2013 on PC
writeRaster(difference, "CHM_San_Genesio/Jenesien.tif")





# POINT CLOUD

# Load the required package
install.packages("lidR")
library(lidR)

# Load Point Cloud
point_cloud <- readLAS("point_cloud.laz")

# Plot r3 Point Cloud
plot(point_cloud)
