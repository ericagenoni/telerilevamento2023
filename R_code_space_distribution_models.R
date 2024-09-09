# SPECIES DISTRIBUTION MODELS (Modelli di Distribuzione delle Specie)

# Installazione e caricamento dei pacchetti necessari
install.packages("sdm") # Pacchetto per il Modelling delle Distribuzioni delle Specie
library(sdm) # Carica il pacchetto 'sdm'
library(rgdal) # Carica il pacchetto 'rgdal' per l'elaborazione di dati geografici
library(raster) # Carica il pacchetto 'raster' per la gestione dei dati raster

# Caricamento di un file incluso nel pacchetto 'sdm'
file <- system.file("external/species.shp", package="sdm") # Ottiene il percorso del file shapefile
file
species_data <- shapefile("C:/Users/briga/AppData/Local/R/win-library/4.2/sdm/external/species.shp") # Caricamento dei dati delle specie dal file shapefile

# Visualizzazione delle informazioni sul dataset
species_data

# Occurrence = Presenza/Assenza della specie (o 1|0)

# Creazione di un grafico con i dati sulle specie
plot(species_data) # Disegna il grafico delle specie
plot(species_data, pch=19) # pch: definisce lo stile dei punti di occorrenza

# Visualizzazione delle occorrenze (presenze e assenze)
species_data$Occurrence

# Creazione di un grafico solo con le presenze (1 = presenza)
presences <- species_data[species_data$Occurrence==1,] # Filtra solo le presenze
presences
plot(presences, col="blue", pch=19) # Disegna il grafico delle presenze in blu

# Creazione di un grafico solo con le assenze (0 = assenza)
absences <- species_data[species_data$Occurrence==0,] # Filtra solo le assenze
absences
plot(absences, col="red", pch=19) # Disegna il grafico delle assenze in rosso

# Creazione di un grafico con tutte le occorrenze, differenziate per colore
plot(presences, col="blue", pch=19) # Disegna le presenze in blu
points(absences, col="red", pch=19) # Disegna le assenze in rosso

# Predittori (variabili ambientali utilizzate per il modello)
path <- system.file("external", package="sdm") # Ottiene il percorso della cartella con i dati
path

# Elenco e combinazione (stack) dei predittori
lst <- list.files(path=path, pattern="asc", full.names=T) # Elenca i file raster
lst
predictors <- stack(lst) # Combina i file raster in un'unica struttura
predictors

# Creazione di un grafico dei predittori
plot(predictors) # Grafico di tutti i predittori
plot(predictors$vegetation) # Grafico del predittore 'vegetation'

# Definizione di una palette di colori personalizzata per i grafici
cl_1 <- colorRampPalette(c("lightyellow", "yellow", "orange", "darkorange", "darkred"))(100) # Creazione di una scala di colori
plot(predictors$vegetation, col=cl_1) # Grafico del predittore 'vegetation' con la nuova palette

# Creazione di grafici con i predittori e le occorrenze insieme
plot(predictors$elevation, col=cl_1, main="Elevation") # Grafico dell'altitudine
points(presences, pch=19) # Mostra le presenze in bassa altitudine

plot(predictors$precipitation, col=cl_1, main="Precipitation") # Grafico delle precipitazioni
points(presences, pch=19) # Mostra le presenze in aree umide

plot(predictors$temperature, col=cl_1, main="Temperature") # Grafico della temperatura
points(presences, pch=19) # Mostra le presenze in aree calde

plot(predictors$vegetation, col=cl_1, main="Vegetation") # Grafico della vegetazione
points(presences, pch=19) # Mostra le presenze dove la copertura vegetale è maggiore

# PREVISIONE DEI MODELLI

# Creazione del modello

# Impostazione dei dati per il modello di distribuzione delle specie
data_sdm <- sdmData(train=species_data, predictors=predictors) # Crea un oggetto 'sdmData' con dati di addestramento
data_sdm

# Creazione del modello di distribuzione
m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation,
          data=data_sdm,
          methods="glm") # Crea un modello con il metodo 'glm' (Generalized Linear Model)
m1

# Creazione del layer di output raster
p1 <- predict(m1, newdata=predictors) # Predice la distribuzione della specie basandosi sui predittori
p1

# Creazione di un grafico dell'output del modello
plot(p1, col=cl_1) # Grafico del risultato della previsione
points(presences, pch=19) # Sovrappone le presenze al grafico

# Aggiunta del layer di output allo stack
s1 <- stack(predictors, p1) # Combina il nuovo layer con i predittori esistenti
plot(s1, col=cl_1) # Grafico del nuovo stack

# Modifica del nome dell'ultimo layer nel grafico
names(s1)[5] <- c("model") # Rinomina l'ultimo layer in 'model'
plot(s1, col=cl_1) # Grafico finale con il nuovo nome del layer
