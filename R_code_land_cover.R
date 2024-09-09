# LAND COVER

# Caricamento dei pacchetti richiesti (raster, ggplot2, patchwork)
library(raster) # Gestione di dati raster
library(ggplot2) # Creazione di grafici con ggplot
install.packages("patchwork")
library(patchwork) # Per combinare due grafici ggplot in un unico grafico

# Impostazione della directory di lavoro
setwd("C:/Data_telerilevamento/lab")

# Caricamento dei dati sulla deforestazione
defor1 <- brick("defor1_.png") # Immagine del 1992
defor2 <- brick("defor2_.png") # Immagine del 2006

# NIR   = 1
# Rosso = 2
# Verde = 3

# Creazione di un multiframe per visualizzare le immagini
par(mfrow=c(2, 1)) # Definizione di due frame verticali
plotRGB(defor1, 1, 2, 3, stretch="lin") # Plot dell'immagine 1992
plotRGB(defor2, 1, 2, 3, stretch="lin") # Plot dell'immagine 2006
dev.off() # Chiusura del dispositivo grafico



# CLASSIFICAZIONE DELL'IMMAGINE DEL 1992

# 1. Estrazione dei valori dell'immagine 1992
singlenr1 <- getValues(defor1)
singlenr1

# 2. Classificazione usando k-means
kcluster1 <- kmeans(singlenr1, centers=2) # Due classi di riferimento
kcluster1

# 3. Ricreazione di un'immagine classificata
defor1_class <- setValues(defor1[[1]], kcluster1$cluster)

# Creazione di un plot per l'immagine classificata
plot(defor1_class)



# CLASSIFICAZIONE DELL'IMMAGINE DEL 2006

# 1. Estrazione dei valori dell'immagine 2006
singlenr2 <- getValues(defor2)
singlenr2

# 2. Classificazione usando k-means
kcluster2 <- kmeans(singlenr2, centers=2) # Due classi di riferimento
kcluster2

# 3. Ricreazione di un'immagine classificata
defor2_class <- setValues(defor2[[1]], kcluster2$cluster)

# Creazione di un plot per l'immagine classificata
plot(defor2_class)



# Creazione di un multiframe per visualizzare entrambe le immagini classificate
par(mfrow=c(2, 1)) # Definizione di due frame verticali
plot(defor1_class) # Plot dell'immagine classificata 1992
plot(defor2_class) # Plot dell'immagine classificata 2006



# Calcolo della percentuale delle classi per il 1992
frequencies1 <- freq(defor1_class) # Calcolo delle frequenze delle classi
frequencies1

tot1 <- ncell(defor1_class) # Numero totale di celle
tot1 # 341292

percentage1 <- (frequencies1*100)/tot1 # Calcolo delle percentuali
percentage1

# Foresta    = 89.74632%
# Suolo nudo = 10.25368%



# Calcolo della percentuale delle classi per il 2006
frequencies2 <- freq(defor2_class) # Calcolo delle frequenze delle classi
frequencies2

tot2 <- ncell(defor2_class) # Numero totale di celle
tot2 # 342726

percentage2 <- (frequencies2*100)/tot2 # Calcolo delle percentuali
percentage2

# Foresta    = 52.06958%
# Suolo nudo = 47.93042%



# Creazione di un dataframe con le percentuali di copertura
cover <- c("Forest","Bare Soil") # Classi di copertura
perc_1992 <- c(89.75, 10.25) # Percentuali per il 1992
perc_2006 <- c(52.07, 47.93) # Percentuali per il 2006
percentages <- data.frame(cover, perc_1992, perc_2006) # Creazione del dataframe
percentages



# Creazione di grafici con ggplot2
ggplot(percentages,
       aes(x=cover, y=perc_1992, color=cover)) +
       geom_bar(stat="identity", # Creazione di un grafico a barre per il 1992
                fill="white")
# Si utilizza "identity" per rappresentare i dati come sono, non per contare

ggplot(percentages

