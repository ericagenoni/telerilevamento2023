#COPERNICUS
# Download e visualizzazione dei dati Earth Observation

# Installazione e caricamento  dei pacchetti necessari
library(raster)    # Pacchetto per la manipolazione e analisi dei dati raster
library(ggplot2)   # Pacchetto per la visualizzazione dei dati
library(viridis)   # Pacchetto per la scala di colori viridis
install.packages("ncdf4") # Installazione del pacchetto ncdf4 per gestire i file NetCDF
library(ncdf4)     # Caricamento del pacchetto ncdf4

# Registrazione e scaricamento dati da:
# https://land.copernicus.vgt.vito.be/PDF/portal/Application.html

# Caricamento dei dati come oggetto raster
soil_moisture <- raster("c_gls_SSM1km_202305090000_CEURO_S1CSAR_V1.2.1.nc") # Caricamento del file NetCDF come raster
soil_moisture # Visualizza l'oggetto raster caricato
ncell(soil_moisture) # Numero di celle nel raster (28311808)
plot(soil_moisture) # Visualizzazione del raster dell'umidità del suolo

# Trasformazione del raster in un dataframe
soil_moisture_df <- as.data.frame(soil_moisture, xy=T) # Conversione del raster in dataframe con coordinate x, y

# Nomi delle colonne del dataframe
colnames(soil_moisture_df) # Visualizzazione dei nomi delle colonne del dataframe

# Creazione del grafico con ggplot
ggplot() +
  geom_raster(soil_moisture_df, # Definisce i dati per il raster
              mapping=aes(x=x, y=y, fill=Surface.Soil.Moisture)) + # Specifica le coordinate e la variabile di riempimento
  ggtitle("Soil Moisture from Copernicus") # Aggiunge un titolo al grafico

# Ritaglio dell'immagine con coordinate specifiche
ext <- c(23, 30, 62, 68) # Definisce l'estensione delle coordinate (bounding box) per il ritaglio
soil_moisture_crop <- crop(soil_moisture, ext) # Ritaglia l'immagine raster utilizzando l'estensione definita
soil_moisture_crop # Visualizza l'immagine ritagliata

# Trasforma l'immagine ritagliata in un dataframe
soil_moisture_crop_df <- as.data.frame(soil_moisture_crop, xy=T) # Conversione dell'immagine ritagliata in dataframe
soil_moisture_crop_df # Visualizza il dataframe ritagliato

# Creazione di un grafico dell'immagine ritagliata con ggplot, aggiungendo la scala di colori viridis
ggplot() +
  geom_raster(soil_moisture_crop_df,
              mapping=aes(x=x, y=y, fill=Surface.Soil.Moisture)) +
  ggtitle("Soil Moisture from Copernicus") +
  scale_fill_viridis() # Aggiunge la scala di colori Viridis per una migliore interpretazione dei dati

# ESERCIZIO: scegliere un'altra immagine da Copernicus e seguire lo stesso percorso

# Caricamento dati come oggetto raster
forest_cover <- raster("c_gls_FCOVER-RT0_202006300000_GLOBE_PROBAV_V2.0.1.nc") # Caricamento di un altro file NetCDF come raster
forest_cover # Visualizzazione del raster caricato
ncell(forest_cover) # Numero di celle nel raster (28311808)
plot(forest_cover) # Visualizzazione del raster della copertura forestale

# Il file è troppo grande, lo ritagliamo
ext_1 <- c(14, 19, 39, 42) # Definisce l'estensione delle coordinate (bounding box) per il ritaglio - Parte del Sud Italia
forest_cover_crop <- crop(forest_cover, ext_1) # Ritaglia il raster utilizzando l'estensione definita
forest_cover_crop # Visualizzazione  dell'immagine ritagliata
plot(forest_cover_crop) # Visualizzazione del raster ritagliato

# Trasformazione dell'immagine ritagliata in un dataframe
forest_cover_crop_df <- as.data.frame(forest_cover_crop, xy=T) # Conversione dell'immagine ritagliata in dataframe

# Nomi delle colonne del dataframe
colnames(forest_cover_crop_df) # Visualizza i nomi delle colonne del dataframe (Fraction.of.green.Vegetation.Cover.1km)

# Creazione di un grafico con ggplot
ggplot() +
  geom_raster(forest_cover_crop_df,
              mapping=aes(x=x, y=y, fill=Fraction.of.green.Vegetation.Cover.1km)) +
  ggtitle("Forest Cover from Copernicus") +
  scale_fill_viridis() # Aggiunge la scala di colori Viridis

# Concentriamoci sull'area del Salento
ext_2 <- c(17, 19, 39.5, 41) # Definisce l'estensione delle coordinate (bounding box) per il ritaglio - Area del Salento
forest_cover_Sal <- crop(forest_cover, ext_2) # Ritaglia il raster per l'area del Salento
forest_cover_Sal # Visualizza l'immagine ritagliata
plot(forest_cover_Sal) # Visualizza il raster ritagliato

# Trasformazione  dell'immagine ritagliata in un dataframe
forest_cover_Sal_df <- as.data.frame(forest_cover_Sal, xy=T) # Conversione dell'immagine ritagliata in dataframe

# Nomi delle colonne del dataframe
colnames(forest_cover_Sal_df) # Visualizza i nomi delle colonne del dataframe (Fraction.of.green.Vegetation.Cover.1km)

# Creazione di un grafico con ggplot
ggplot() +
  geom_raster(forest_cover_Sal_df,
              mapping=aes(x=x, y=y, fill=Fraction.of.green.Vegetation.Cover.1km)) +
  ggtitle("Forest Cover of Salento from Copernicus") +
  scale_fill_viridis() # Aggiunge la scala di colori Viridis
