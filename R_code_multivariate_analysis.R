# ANALISI MULTIVARIATA

# Caricamento dei pacchetti necessari
library(raster)
library(ggplot2)
library(viridis)

# Impostazione della directory di lavoro
setwd("C:/Data_telerilevamento/lab")

# Importazione dei dati
sen_1 <- brick("sentinel.png")  # Caricamento dell'immagine satellitare come un oggetto brick (multibanda)
sen_1  # Visualizzazione delle informazioni sull'oggetto caricato
ncell(sen_1) # Calcolo del numero totale di celle dell'immagine (633612)
plot(sen_1)  # Creazione di un grafico delle bande caricate

# Raggruppamento delle bande, rimuovendo l'ultima (vuota)
sen_2 <- stack(sen_1[[1]], sen_1[[2]], sen_1[[3]])  # Creazione di uno stack con le prime tre bande
sen_2  # Visualizzazione delle informazioni sull'oggetto stack
plot(sen_2)  # Creazione di un grafico delle bande selezionate

# Confronto tra le bande a coppie
pairs(sen_2)  # Creazione di una matrice di grafici per il confronto tra le bande

# Analisi delle Componenti Principali (PCA)
sample <- sampleRandom(sen_2, 10000)  # Estrazione di un campione casuale di 10.000 pixel dallo stack
PCA <- prcomp(sample)  # Esecuzione dell'analisi delle componenti principali sul campione

# Spiegazione della varianza
summary(PCA)  # Mostra la percentuale di varianza spiegata da ogni componente principale
# La prima componente nell'elenco è quella con la maggiore variabilità

# Correlazione con le bande originali
PCA  # Mostra i risultati della PCA, inclusi i coefficienti di correlazione delle bande originali

# Creazione di mappe delle componenti principali
PCI <- predict(sen_2, PCA, index=c(1:3))  # Previsione delle componenti principali per l'intero stack di bande
plot(PCI)  # Creazione di un grafico delle prime tre componenti principali
plot(PCI[[1]])  # Creazione di un grafico della prima componente principale
plot(PCI[[2]])  # Creazione di un grafico della seconda componente principale
plot(PCI[[3]])  # Creazione di un grafico della terza componente principale

# Conversione delle componenti principali in un dataframe
PCId <- as.data.frame(PCI[[1]], xy=T)  # Conversione della prima componente principale in un dataframe con coordinate spaziali
PCId  # Visualizzazione del dataframe creato

# Creazione di un grafico con ggplot() per la prima componente principale
ggplot() +
  geom_raster(PCId,
              mapping=aes(x=x, y=y, fill=PC1)) +  # Creazione di una mappa raster della prima componente principale
  scale_fill_viridis()  # Applicazione della palette di colori "viridis" al grafico

# Creazione di un grafico con ggplot() usando la palette di colori "magma"
ggplot()+
  geom_raster(PCId,
              mapping=aes(x=x, y=y, fill=PC1))+
  scale_fill_viridis(option="magma")  # Utilizzo della palette di colori "magma"

# Creazione di un grafico con ggplot() usando la palette di colori "inferno"
ggplot()+
  geom_raster(PCId,
              mapping=aes(x=x, y=y, fill=PC1))+
  scale_fill_viridis(option="inferno")  # Utilizzo della palette di colori "inferno"

# Calcolo della deviazione standard focale
SD3 <- focal(PCI[[1]], matrix(1/9, 3, 3), fun=sd)  # Calcolo della deviazione standard utilizzando una finestra 3x3

# Conversione della deviazione standard in un dataframe
SD3d <- as.data.frame(SD3, xy=T)  # Conversione del risultato in un dataframe con coordinate spaziali
SD3d  # Visualizzazione del dataframe creato

# Creazione di un grafico con ggplot() per la deviazione standard
ggplot() +
  geom_raster(SD3d,
              mapping=aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis()  # Applicazione della palette di colori "viridis" al grafico

# Accelerazione dell'analisi
# Aggregazione delle celle: ricampionamento
SEN_res <- aggregate(sen_1, fact=10)  # Riduzione della risoluzione dell'immagine aggregando le celle con un fattore di 10
SEN_res  # Visualizzazione delle informazioni sull'immagine ricampionata
plot(SEN_res)  # Creazione di un grafico dell'immagine ricampionata

# Ripetizione dell'Analisi delle Componenti Principali
