# VARIABILITÀ

# Caricamento dei pacchetti necessari
library(raster)   # Carica il pacchetto 'raster' per la gestione dei dati raster
library(ggplot2)  # Carica il pacchetto 'ggplot2' per la creazione di grafici
library(patchwork) # Carica il pacchetto 'patchwork' per combinare più grafici
install.packages("viridis") # Installa il pacchetto 'viridis' per la palette di colori
library(viridis)  # Carica il pacchetto 'viridis'

# Impostazione della directory di lavoro
setwd("C:/Data_telerilevamento/lab") # Imposta la directory di lavoro

# Importazione dell'immagine "similaun.png" dal satellite Sentinel
sen <- brick("sentinel.png") # Carica l'immagine satellite come un oggetto di tipo 'brick' (multi-layer)
ncell(sen) # Mostra il numero di celle (pixel) dell'immagine: 633612

# Visualizzazione dell'immagine
plot(sen) # Disegna l'immagine
plotRGB(sen, 1, 2, 3, stretch="lin") # Visualizza l'immagine in RGB utilizzando i canali NIR, Rosso e Verde

# Canali dell'immagine
# NIR   = 1 (Infrarosso vicino)
# Rosso = 2
# Verde = 3

# Visualizzazione dell'immagine con NIR sul componente verde
plotRGB(sen, 2, 1, 3, stretch="lin") # Scambia i canali NIR e Rosso per osservare l'immagine con diversa combinazione

# Calcolo della variabilità sul canale NIR
nir <- sen[[1]] # Estrae il primo layer dell'immagine (NIR)
mean3 <- focal(nir, matrix(1/9, 3, 3), fun=mean) # Calcola la media focalizzata utilizzando una matrice 3x3
# Calcolo dei valori focali per il vicinato delle celle focali utilizzando una matrice di pesi con la funzione mean()
plot(mean3) # Grafica della media focalizzata

sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd) # Calcola la deviazione standard focalizzata utilizzando una matrice 3x3
plot(sd3) # Grafica della deviazione standard focalizzata

# Creazione di un dataframe per ggplot
sd3_d <- as.data.frame(sd3, xy=T) # Converte il raster in un dataframe con le coordinate x e y

# Creazione del grafico con ggplot2
ggplot() +
  geom_raster(sd3_d,
              mapping=aes(x=x, y=y, fill=layer)) # Grafico raster con le coordinate x e y e i valori della deviazione standard

# Creazione del grafico con la palette viridis
ggplot() +
  geom_raster(sd3_d,
              mapping=aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis() # Aggiunge la scala di colori 'viridis'

# Utilizzo della palette 'Cividis' (scala di colori)
p1 <- ggplot() +
      geom_raster(sd3_d,
                  mapping=aes(x=x, y=y, fill=layer)) +
      scale_fill_viridis(option="cividis") # Utilizza la scala di colori 'cividis'

# Utilizzo della palette 'Magma' (scala di colori)
ggplot() +
geom_raster(sd3_d,
            mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="magma") # Utilizza la scala di colori 'magma'

# Aggiunta di un titolo al grafico
p2 <- ggplot() +
      geom_raster(sd3_d,
                  mapping=aes(x=x, y=y, fill=layer)) +
      scale_fill_viridis(option="magma") +
      ggtitle("Deviazione Standard con la Scala di Colori Magma") # Aggiunge un titolo al grafico

p1 + p2 # Combina i due grafici usando 'patchwork'

# Creazione di un multi-frame con patchwork

# Grafico con la scala di colori Viridis
p1 <- ggplot() +
      geom_raster(sd3_d,
                  mapping=aes(x=x, y=y, fill=layer)) +
      scale_fill_viridis() +
      ggtitle("Deviazione Standard con la Scala di Colori Viridis")

# Grafico con la scala di colori Inferno
p2 <- ggplot() +
      geom_raster(sd3_d,
                  mapping=aes(x=x, y=y, fill=layer)) +
      scale_fill_viridis(option="inferno") +
      ggtitle("Deviazione Standard con la Scala di Colori Inferno")

p1 + p2 # Combina i due grafici (Viridis e Inferno)

# ESERCIZIO: Grafico dell'immagine originale (NIR) e della sua deviazione standard
nir_d <- as.data.frame(nir, xy=T) # Converte il raster NIR in un dataframe con le coordinate x e y

p3 <- ggplot() +
      geom_raster(nir_d,
                  mapping=aes(x=x, y=y, fill=sentinel_1)) +
      scale_fill_viridis(option="cividis") +
      ggtitle("NIR con la Scala di Colori Viridis") # Grafico dell'immagine NIR con la palette Cividis

p3 + p1 # Combina il grafico dell'immagine NIR con il grafico della deviazione standard

