# ANALISI DELLE SERIE TEMPORALI

# Installazione dei pacchetti necessari
install.packages("rasterVis")
install.packages("rgdal")

# Caricamento dei pacchetti necessari
library(raster)
library(rasterVis)
library(rgdal)

# 1. AUMENTO DELLE TEMPERATURE IN GROENLANDIA

# Impostazione della directory di lavoro
setwd("C:/Data_telerilevamento/lab/greenland_data")

# Importazione delle immagini .tif utilizzando la funzione raster()
lst_2000 <- raster("lst_2000.tif")
lst_2005 <- raster("lst_2005.tif")
lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst_2015.tif")

# Visualizzazione della lista degli oggetti importati/caricati
ls()

# Visualizzazione delle 4 immagini in un unico frame multipezzo
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)
dev.off()

# Elenco dei file .tif
rlist_1 <- list.files(pattern="lst")
rlist_1

# Applicazione di una funzione su una lista/vector
import_1 <- lapply(rlist_1, raster) # Applicazione della funzione raster() ai file della lista
import_1

# Creazione di uno stack di layer da un dataframe/lista
TGr <- stack(import_1)
TGr # 4 layer
# Lo stacking concatena più layer in un unico layer

# Visualizzazione dello stack TGr
plot(TGr) # ora abbiamo le 4 immagini in un unico elemento

# Visualizzazione con plotRGB()
plotRGB(TGr, 1, 2, 3, stretch="Lin")
plotRGB(TGr, 2, 3, 4, stretch="Lin")

# Visualizzazione utilizzando una palette di colori
cl_0 <- colorRampPalette(c("blue","lightblue","pink","red"))(100)
plot(TGr, col=cl_0)
dev.off()

# Calcolo e visualizzazione delle differenze tra 2005 e 2000
dif_05_00 = TGr[[2]] - TGr[[1]]
plot(dif_05_00, col=cl_0)
dev.off()

# 2. DIMINUZIONE DI NO2 DURANTE IL PERIODO DI LOCKDOWN

# Impostazione della nuova directory di lavoro
setwd("C:/Data_telerilevamento/lab/EN")

# Importazione e visualizzazione del primo file immagine
EN01 <- raster("EN_0001.png")
EN01
plot(EN01) # Gennaio (prima dell'inizio del lockdown)

# Visualizzazione di EN01 utilizzando una palette di colori
cl_1 <- colorRampPalette(c("yellow","orange","red"))(100)
plot(EN01, col=cl_1)

# Importazione e visualizzazione dell'ultimo file immagine
EN13 <- raster("EN_0013.png")
EN13
plot(EN13, col=cl_1) # Marzo (dopo l'inizio del lockdown)

# Importazione dell'intero set di immagini
rlist_2 <- list.files(pattern="EN")
rlist_2

# Applicazione di una funzione su una lista/vector
import_2 <- lapply(rlist_2, raster) # Applicazione della funzione raster() ai file della lista
import_2

# Creazione di uno stack di layer da un dataframe/lista
EN <- stack(import_2)
EN
# Lo stacking concatena più layer in un unico layer

# Visualizzazione di tutte le immagini
plot(EN, col=cl_1)

# Verifica visualizzando i plot in un frame multipezzo
par(mfrow=c(1,2))
plot(EN[[1]], col=cl_1)
plot(EN01, col=cl_1)
dev.off()

# Verifica calcolando le differenze
dif_check <- EN01 - EN[[1]]
dif_check
plot(dif_check)

# Visualizzazione del primo e dell'ultimo file immagine con funzione par()
par(mfrow=c(1,2))
plot(EN01, col=cl_1)
plot(EN13, col=cl_1)
dev.off()

# Creazione di uno stack tra il primo e l'ultimo file immagine
EN_01_13 <- stack(EN01, EN13)

# Calcolo delle differenze tra EN01 e EN13
dif_01_13 <- EN01 - EN13
cl_2 <- colorRampPalette(c("blue","white","red"))(100)

# Visualizzazione delle differenze tra EN01 e EN13
plot(dif_01_13, col=cl_2)
dev.off()

# Visualizzazione con plotRGB()
par(mfrow=c(1,2))
plotRGB(EN, 1, 7, 13, stretch="lin")
plotRGB(EN, 1, 7, 13, stretch="hist")
