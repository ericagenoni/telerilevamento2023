# Il mio primo codice su GitHub
# Installiamo il pacchetto "raster"

install.packages("raster")

library(raster)

# Impostiamo la directory di lavoro

setwd("C:/telerilevamento_2024/p224r63_2011") # Windows

# La funzione "brick" (inclusa nel pacchetto "raster") raccoglie tutti questi dati insieme e li carica in R.
# Creiamo un nuovo file con tutti questi dati al suo interno.
l2011 <- brick("p224r63_2011_masked.grd")

# Visualizziamo i dati
plot(l2011)

# https://www.r-graph-gallery.com/42-colors-names.html (sito web dove si può scegliere una palette di colori.)
cl <- colorRampPalette(c("red", "orange", "yellow"))(100) # 100 indica le sfumature
# Visualizziamo i dati con la nuova palette
plot(l2011, col=cl)

# Esercizio: cambiare la gamma di colori per tutte le immagini
cl <- colorRampPalette(c("blue", "darkorchid", "aquamarine"))(100) # 100 indica le sfumature
plot(l2011, col=cl)

# Esercizio: visualizzare la banda NIR
# b1 = blu
# b2 = verde
# b3 = rosso
# b4 = infrarosso NIR

# Visualizziamo un singolo elemento
plot(l2011[[4]], col=cl) # Visualizza la banda numero 4.
# Oppure possiamo richiamarla per nome: l2011$B4_sre
plot(l2011$B4_sre, col=cl)
dev.off()
# Per chiudere tutte le finestre di grafico aperte dev.off()

nir <- l2011[[4]] 
# Oppure: nir <- l2011$B4_sre
plot(nir, col=cl)

# Esportare grafici in R
# La funzione pdf ci permette di esportare grafici in formato PDF
pdf("myfirstgraph.pdf")
plot(l2011$B4_sre, col=cl)
dev.off()

# Esercizio due
pdf("mysecondtgraph.pdf")
par(mfrow=c(2,2))
# par(): Questa è la funzione principale per impostare o ottenere i parametri grafici.
# mfrow: Questo è un argomento specifico della funzione par() che controlla la disposizione di più grafici.
# c(2,2): Questo è un vettore che specifica il numero di righe e colonne per la griglia di grafici. In questo caso, c(2,2) indica una griglia di 2x2.

# Ora scegliamo una palette di colori per ogni banda.
# B1 Blu
clb <- colorRampPalette(c("blue", "blue4", "blueviolet"))(100)
plot(l2011[[1]], col=clb)

# B2 Verde
clg <- colorRampPalette(c("chartreuse", "chartreuse3", "chartreuse4"))(100)
plot(l2011[[2]], col=clg)

# B3 Rosso
clr <- colorRampPalette(c("brown1", "brown3", "brown4"))(100)
plot(l2011[[3]], col=clr)

# B4 NIR
clrin <- colorRampPalette(c("darkmagenta", "darkorchid1", "darkorchid4"))(100)
plot(l2011[[4]], col=clrin)

dev.off()

# Visualizzare diverse bande in un multiframe
par(mfrow=c(2,1))
plot(l2011[[3]], col=cl)
plot(l2011[[4]], col=cl)

# Visualizzare le prime 4 bande/livelli
par(mfrow=c(2,2))

# Visualizzazione RGB
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin")

# Multiframe con colori naturali e falsi
par(mfrow=c(2,1))
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")

# plotRGB(l2011, ...): Questa funzione suggerisce che plotRGB() prende come primo argomento un oggetto chiamato l2011 (presumibilmente contenente dati), seguito da altri argomenti per specificare i colori.
# r=3, g=2, b=1: Questi argomenti controllano le componenti rosso (R), verde (G) e blu (B) dei colori utilizzati nel grafico.
# stretch="Lin": Questo argomento controlla come i valori dei colori vengono "stirati" o scalati all'interno del grafico. "Lin" potrebbe indicare uno stiramento lineare.

# Stiramento istogramma
par(mfrow=c(2,1))
plotRGB(l2011, r=3, g=2, b=1, stretch="Hist")
plotRGB(l2011, r=4, g=3, b=2, stretch="Hist")

# Stiramento lineare vs. istogramma
par(mfrow=c(2,1))
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Hist")

# Esercizio: visualizzare la banda NIR
plot(l2011[[4]])

plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin")

# Esercizio: importare l'immagine del 1988
l1988 <- brick("p224r63_1988_masked.grd")

# Esercizio: visualizzare in spazio RGB (colori naturali)
plotRGB(l1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(l1988, r=4, g=3, b=2, stretch="Lin")

plotRGB(l1988, 4, 3, 2, stretch="Lin")

# Multiframe
par(mfrow=c(2,1))
plotRGB(l1988, 4, 3, 2, stretch="Lin")
plotRGB(l2011, 4, 3, 2, stretch="Lin")

dev.off()
plotRGB(l1988, 4, 3, 2, stretch="Hist")

# Multiframe con 4 immagini
par(mfrow=c(2,2))
plotRGB(l1988, 4, 3, 2, stretch="Lin")
plotRGB(l2011, 4, 3, 2, stretch="Lin")
plotRGB(l1988, 4, 3, 2, stretch="Hist")
plotRGB(l2011, 4, 3, 2, stretch="Hist")

