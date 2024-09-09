# LiDAR - 3D in R

# LiDAR è una tecnologia per determinare le distanze tramite il targeting di un oggetto o di una superficie
# con un laser e la misurazione del tempo che la luce riflessa impiega per ritornare al ricevitore.
# Può scansionare in più direzioni, risultando in un'immagine 3D.

# Caricamento dei pacchetti richiesti
library(raster) # Analisi e modellizzazione di dati geografici
library(rgdal) # Libreria di astrazione dei dati geospaziali
library(viridis) # Libreria per la scala di colori
library(ggplot2) # Libreria per la visualizzazione dei dati
library(patchwork) # Libreria per combinare più grafici

# Impostazione della directory di lavoro
setwd("C:/Data_telerilevamento/lab/dati")

# 2013

# Caricamento dei dati: Modello digitale di superficie 2013
dsm_2013 <- raster("2013Elevation_DigitalElevationModel-0.5m.tif")

# Visualizzazione delle informazioni sui dati caricati
dsm_2013

# Creazione di un plot per il DSM 2013
plot(dsm_2013, main="LiDAR Digital Surface Model San Genesio/Jenesien")

# Caricamento dei dati: Modello digitale del terreno 2013
dtm_2013 <- raster("2013Elevation_DigitalTerrainModel-0.5m.tif")

# Visualizzazione delle informazioni sui dati caricati
dtm_2013

# Creazione di un plot per il DTM 2013
plot(dtm_2013, main="LiDAR Digital Terrain Model San Genesio/Jenesien")

# Creazione del Canopy Height Model (CHM) 2013 come differenza tra DSM e DTM
chm_2013 <- dsm_2013 - dtm_2013

# Visualizzazione delle informazioni sul CHM
chm_2013

# Conversione del CHM 2013 in un dataframe
chm_2013_df <- as.data.frame(chm_2013, xy=T)

# Creazione di un plot del CHM con ggplot
ggplot() +
  geom_raster(chm_2013_df,
              mapping=aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis() +
  ggtitle("CHM 2013 San Genesio/Jenesien")

# Salvataggio del CHM 2013 sul PC
writeRaster(chm_2013, "CHM_2013_San_Genesio/Jenesien.tif")

# 2004

# Caricamento dei dati: Modello digitale di superficie 2004
dsm_2004 <- raster("2004Elevation_DigitalElevationModel-2.5m.tif")

# Visualizzazione delle informazioni sui dati caricati
dsm_2004

# Creazione di un plot per il DSM 2004
plot(dsm_2004, main="LiDAR Digital Surface Model San Genesio/Jenesien")

# Caricamento dei dati: Modello digitale del terreno 2004
dtm_2004 <- raster("2004Elevation_DigitalTerrainModel-2.5m.tif")

# Visualizzazione delle informazioni sui dati caricati
dtm_2004

# Creazione di un plot per il DTM 2004
plot(dtm_2013, main="LiDAR Digital Terrain Model San Genesio/Jenesien")

# Creazione del Canopy Height Model (CHM) 2004 come differenza tra DSM e DTM
chm_2004 <- dsm_2004 - dtm_2004

# Visualizzazione delle informazioni sul CHM
chm_2004

# Conversione del CHM 2004 in un dataframe
chm_2004_df <- as.data.frame(chm_2004, xy=T)

# Creazione di un plot del CHM con ggplot
ggplot() +
  geom_raster(chm_2004_df,
              mapping=aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis() +
  ggtitle("CHM 2004 San Genesio/Jenesien")

# Salvataggio del CHM 2004 sul PC
writeRaster(chm_2004, "CHM_2004_San_Genesio/Jenesien.tif")

# Calcolo della differenza tra i CHM
difference <- chm_2013 - chm_2004 # ERRORE

# Risampling del CHM 2013 per adattarlo al 2004 (2.5 m)
chm_2013_rs <- resample(chm_2013, chm_2004)

# Calcolo della differenza tra i CHM
difference <- chm_2013_rs - chm_2004

# Conversione della differenza in un dataframe
difference_df <- as.data.frame(difference, xy=T)

# Creazione di un plot della differenza tra i CHM
ggplot() +
  geom_raster(difference_df,
              mapping=aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis() +
  ggtitle("Difference CHM San Genasio/Jenesien")

# Salvataggio della differenza dei CHM sul PC
writeRaster(difference, "CHM_San_Genesio/Jenesien.tif")

# POINT CLOUD

# Installazione del pacchetto richiesto
install.packages("lidR")
library(lidR)

# Caricamento del Point Cloud
point_cloud <- readLAS("point_cloud.laz")

# Creazione di un plot per il Point Cloud
plot(point_cloud)

