# My first code in Git Hub
# Let's install the raster package

install.packages("raster")

library(raster)

#setting the working directory

setwd("C:/lab/p224r63_2011.grd")#windows
#Import data with the function "brick"
l2011 <- brick("p224r63_2011_masked.grd")

# plotting the data in a savage manner
plot(l2011)

# https://www.r-graph-gallery.com/42-colors-names.html (where you can choose the color palette)
cl <- colorRampPalette(c("red","orange","yellow"))(100) # 100 are the shades
#plotting data with the new palette
plot(l2011, col=cl)

# Exercise: change the colour gamut for all the images
cl <- colorRampPalette(c("cyan","azure","darkorchid","aquamarine"))(100) # 100 are the shades
plot(l2011, col=cl)

#exercise: plot the NIR band 
# b1 = blue
# b2 = green
# b3 = red
# b4 = infrared NIR

# plotting one element
plot(l2011[[4]], col=cl)
#or
plot(l2011$B4_sre, col=cl)
dev.off()
#to close the window dev.off()

nir <- l2011[[4]] 
# or: nir <- l2011$B4_sre
plot(nir, col=cl)


# Export graphs in R
#the function pdf allow us to export pdf files
pdf("myfirstgraph.pdf")
plot(l2011$B4_sre, col=cl)
dev.off()


# Exercise two
pdf("mysecondtgraph.pdf")
par(mfrow=c(2,2))
# we choose a different palette for each band  
clb <- colorRampPalette(c("blue", "blue4", "blueviolet")) (100)
plot(l2011[[1]], col=clb)


clg <- colorRampPalette(c("chartreuse", "chartreuse3", "chartreuse4")) (100)
plot(l2011[[2]], col=clg)


clr <- colorRampPalette(c("brown1", "brown3", "brown4")) (100)
plot(l2011[[3]], col=clr)


clrin <-  colorRampPalette(c("darkmagenta", "darkorchid1", "darkorchid4")) (100)
plot(l2011[[4]], col=clrin)

dev.off()

# Plotting several bands in a multiframe
par(mfrow=c(2,1))
plot(l2011[[3]], col=cl)
plot(l2011[[4]], col=cl)

# Plotting the first 4 layers / bands
par(mfrow=c(2,2))

# blue
clb <- colorRampPalette(c("blue4","blue2","light blue"))(100) # 100 sono le sfumature
plot(l2011[[1]], col=clb)

clg <- colorRampPalette(c("chartreuse4","chartreuse2","chartreuse"))(100) # 100 sono le sfumature
plot(l2011[[2]], col=clg)

clr <- colorRampPalette(c("coral3","coral1","coral"))(100) # 100 sono le sfumature
plot(l2011[[3]], col=clr)

cln <- colorRampPalette(c("darkorchid4","darkorchid2","darkorchid4"))(100) # 100 sono le sfumature
plot(l2011[[4]], col=cln)

# RGB plotting
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin")

# Multiframe with natural and false colours
par(mfrow=c(2,1))
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")

# Histogram stretching
par(mfrow=c(2,1))
plotRGB(l2011, r=3, g=2, b=1, stretch="Hist")
plotRGB(l2011, r=4, g=3, b=2, stretch="Hist")

# Linear vs. Histogram stretching
par(mfrow=c(2,1))
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Hist")

# Exercise: plot the NIR band
plot(l2011[[4]])

plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin")

# Exercise: import the 1988 image
l1988 <- brick("p224r63_1988_masked.grd")

# Exercise: plot in RGB space (natural colours)
plotRGB(l1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(l1988, r=4, g=3, b=2, stretch="Lin")

plotRGB(l1988, 4, 3, 2, stretch="Lin")

# multiframe
par(mfrow=c(2,1))
plotRGB(l1988, 4, 3, 2, stretch="Lin")
plotRGB(l2011, 4, 3, 2, stretch="Lin")

dev.off()
plotRGB(l1988, 4, 3, 2, stretch="Hist")

# multiframe with 4 images
par(mfrow=c(2,2))
plotRGB(l1988, 4, 3, 2, stretch="Lin")
plotRGB(l2011, 4, 3, 2, stretch="Lin")
plotRGB(l1988, 4, 3, 2, stretch="Hist")
plotRGB(l2011, 4, 3, 2, stretch="Hist")
