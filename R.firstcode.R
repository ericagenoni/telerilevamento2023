# My first code in Git Hub
# Let's install the raster package

install.packages("raster")

library(raster)

#setting the working directory

setwd("C:/telerilevamento_2024/p224r63_2011")#windows

# "brick" function (included in "raster" package) swill store all these data together and project them into R. Let's create a new 
# file with all these data inside.
l2011 <- brick("p224r63_2011_masked.grd")

# plotting data 
plot(l2011)

# https://www.r-graph-gallery.com/42-colors-names.html (is the website where you can choose a color palette.)
cl <- colorRampPalette(c("red","orange","yellow"))(100) # 100 are the shades
#plotting data with the new palette
plot(l2011, col=cl)

# Exercise: change the colour gamut for all the images
cl <- colorRampPalette(c("blue","darkorchid","aquamarine"))(100) # 100 are the shades
plot(l2011, col=cl)

#exercise: plot the NIR band 
# b1 = blue
# b2 = green
# b3 = red
# b4 = infrared NIR

# plotting one element
plot(l2011[[4]], col=cl)# this is the plot of the band number 4.
#or we could even recall it by its name: l2011$b4_sre
plot(l2011$B4_sre, col=cl)
dev.off()
#to close all the window dev.off()

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
#par(): This is the main function for setting or getting graphical parameters.
#mfrow: This is a specific argument within the par() function that controls the arrangement of multiple plots.
#c(2,2): This is a vector specifying the number of rows and columns for the plot grid. In this case, c(2,2) indicates a 2x2 grid.

#Now let's choose a color palette for each band.
#B1 Blue
clb <- colorRampPalette(c("blue", "blue4", "blueviolet")) (100)
plot(l2011[[1]], col=clb)

#B2 Green
clg <- colorRampPalette(c("chartreuse", "chartreuse3", "chartreuse4")) (100)
plot(l2011[[2]], col=clg)

#B3 Red
clr <- colorRampPalette(c("brown1", "brown3", "brown4")) (100)
plot(l2011[[3]], col=clr)

#B4 NIR
clrin <-  colorRampPalette(c("darkmagenta", "darkorchid1", "darkorchid4")) (100)
plot(l2011[[4]], col=clrin)

dev.off()

# Plotting several bands in a multiframe
par(mfrow=c(2,1))
plot(l2011[[3]], col=cl)
plot(l2011[[4]], col=cl)

# Plotting the first 4 layers / bands
par(mfrow=c(2,2))


# RGB plotting
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin")

# Multiframe with natural and false colours
par(mfrow=c(2,1))
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")

#plotRGB(l2011, ...): This suggests that plotRGB() is a function that takes an object called l2011 (presumably containing data) as the first argument, followed by other arguments for color specification.
#r=3, g=2, b=1: These arguments likely control the red (R), green (G), and blue (B) components of the colors used in the plot. In this case, the color would be a shade of red with specific intensity levels.
#stretch="Lin": This argument might control how the color values are stretched or scaled within the plot. "Lin" could indicate a linear stretching.

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
