require("ggplot2")
require("ggthemes")

notas <- read.csv("notas_corte_hasta_2016.csv",sep=",")
notas$Año <- as.numeric(notas$Año)
notas$Nota.general <- as.numeric(notas$Nota.general)

ggplot(notas)+geom_line(aes(x=Año,y=Nota.general,group=interaction(Grado.en,Centro,Universidad),color=Universidad))+geom_point(aes(x=Año,y=Nota.general,color=Universidad,shape=Rama))

notas.granada <- notas[notas$Universidad=="GRANADA",]
ggplot(notas.granada)+geom_line(aes(x=Año,y=Nota.general,group=interaction(Grado.en,Centro),color=Centro))+geom_point(aes(x=Año,y=Nota.general,color=Centro,shape=Rama))
notas.granada$Titulación = paste(notas.granada$Grado.en,notas.granada$Centro)
notas.granada <- notas[notas$Nota.general>5,]
ggplot(notas.granada)+geom_line(aes(x=Año,y=Nota.general))+geom_point(aes(x=Año,y=Nota.general,color=Centro,shape=Rama))+facet_grid(. ~ Titulación)
