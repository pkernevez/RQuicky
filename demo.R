## Lecture du fichier CSV 
data = read.csv("access.log.out", sep=";")

## aperçu des colonnes et données 
str(data)

## données 
head(data)

## Résumé des données
summary(data)

## Les quantiles : le seuil tel que les 9/10ème (95/100ème) des valeurs sont inférieures à ce seuil
quantile(data$duration, c(0.90,0.95))

### Tracer tous les temps de réponse en fonction des points
png('work/alldata.png', width=800, height=300)
plot(data$duration, type="l", col="blue", main="Pas trop utilisable")
dev.off()

### Histogramme
pdf('work/histogramme.pdf',width=15, height=8)
hist(data$duration, col="green")
dev.off()

### Distribution
pdf('work/distribution.pdf',width=15, height=8)
plot(density(data$duration,n=4000),xlim=c(0,5e6), col="blue",lwd=2)
dev.off()

### Temps de réponse heure par heure 
#Min, mean et quantile 95
png("work/minMeanQuantile.png", width=1000, height=800)
mesureByHours = tapply(data$duration, substr(data$date,1,13), function(i){quantile(i,0.90)})
plot(mesureByHours, type="l", col="blue", xaxt="n", xlab="temps" )
mesureByHours = tapply(data$duration, substr(data$date,1,13), mean)
points(mesureByHours, type="l", col="red")
mesureByHours = tapply(data$duration, substr(data$date,1,13), min)
points(mesureByHours, type="l", col="brown")
dev.off()

### Avec des times series (POSXct)
png('work/alldataTS.png', width=800, height=300)
data$date2 = as.POSIXct( data$date,    format="%Y/%m/%d %H:%M:%S")
library(lattice)
str(data)
xyplot( duration ~ date2, data=data, type="l" )
dev.off()
