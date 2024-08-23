#quesito 1)

realestate_texas <- read.csv("C:/Users/Vittorio D'Onofrio/Downloads/realestate_texas.csv")


#quesito 2)
sapply(realestate_texas, typeof)


#quesito 3)

#moda:
sapply(realestate_texas, table)

for (i in c(2010:2014) ){
  print(
    table(realestate_texas[which(realestate_texas$city=="Beaumont"),]
          [which(realestate_texas$year==i),]$month)
  )
  
  print(
    table(realestate_texas[which(realestate_texas$city=="Bryan-College Station"),]
          [which(realestate_texas$year==i),]$month)
  )
  print(
    table(realestate_texas[which(realestate_texas$city=="Tyler"),]
          [which(realestate_texas$year==i),]$month)
  )
  print(
    table(realestate_texas[which(realestate_texas$city=="Wichita Falls"),]
          [which(realestate_texas$year==i),]$month)
  )
}

#calcolo indici di posizione, variabilità e forma:

install.packages("moments")
library(moments)

#sales:
min(realestate_texas$sales)
max(realestate_texas$sales)
mean(realestate_texas$sales)

median(realestate_texas$sales)
quantile(realestate_texas$sales)

var(realestate_texas$sales)
sd(realestate_texas$sales)

skewness(realestate_texas$sales)
kurtosis(realestate_texas$sales)-3

#volume:
min(realestate_texas$volume)
max(realestate_texas$volume)
mean(realestate_texas$volume)

median(realestate_texas$volume)
quantile(realestate_texas$volume)

var(realestate_texas$volume)
sd(realestate_texas$volume)

skewness(realestate_texas$volume)
kurtosis(realestate_texas$volume)-3

#median_price:
min(realestate_texas$median_price)
max(realestate_texas$median_price)
mean(realestate_texas$median_price)

median(realestate_texas$median_price)
quantile(realestate_texas$median_price)

var(realestate_texas$median_price)
sd(realestate_texas$median_price)

skewness(realestate_texas$median_price)
kurtosis(realestate_texas$median_price)-3


#listings:
min(realestate_texas$listings)
max(realestate_texas$listings)
mean(realestate_texas$listings)

median(realestate_texas$listings)
quantile(realestate_texas$listings)

var(realestate_texas$listings)
sd(realestate_texas$listings)

skewness(realestate_texas$listings)
kurtosis(realestate_texas$listings)-3

#months_inventory:
min(realestate_texas$months_inventory)
max(realestate_texas$months_inventory)
mean(realestate_texas$months_inventory)

median(realestate_texas$months_inventory)
quantile(realestate_texas$months_inventory)

var(realestate_texas$months_inventory)
sd(realestate_texas$months_inventory)

skewness(realestate_texas$months_inventory)
kurtosis(realestate_texas$months_inventory)-3

#year:
min(realestate_texas$year)
max(realestate_texas$year)
mean(realestate_texas$year)

median(realestate_texas$year)
quantile(realestate_texas$year)

var(realestate_texas$year)
sd(realestate_texas$year)

skewness(realestate_texas$year)
kurtosis(realestate_texas$year)-3

#month:
min(realestate_texas$month)
max(realestate_texas$month)
mean(realestate_texas$month)

median(realestate_texas$month)
quantile(realestate_texas$month)

var(realestate_texas$month)
sd(realestate_texas$month)

skewness(realestate_texas$month)
kurtosis(realestate_texas$month)-3

#calcolo distribuzione di frequenza della variabile city:
N=nrow(realestate_texas)
ni <- table(realestate_texas$city)
fi <- table(realestate_texas$city)/N
Ni <- cumsum(ni)
Fi <- Ni/N
cbind(fi, ni, Ni, Fi)


#quesito 4)

cv <- function(x){
  return(sd(x)/mean(x)*100)
}

y_cv <- cv(realestate_texas$year)
m_cv <- cv(realestate_texas$month)
s_cv <- cv(realestate_texas$sales)
v_cv <- cv(realestate_texas$volume)
mp_cv <- cv(realestate_texas$median_price)
l_cv <- cv(realestate_texas$listings)
mi_cv <- cv(realestate_texas$months_inventory)


cv_vect <- c(y_cv, m_cv, s_cv, v_cv, mp_cv, l_cv, mi_cv)
max(cv_vect)



y_sk<- skewness(realestate_texas$year)
m_sk<- skewness(realestate_texas$month)
s_sk<-skewness(realestate_texas$sales)
v_sk<-skewness(realestate_texas$volume)
mp_sk<- skewness(realestate_texas$median_price)
l_sk<- skewness(realestate_texas$listings)
mi_sk<- skewness(realestate_texas$months_inventory)

skew_vect <- c(y_sk,m_sk,s_sk,v_sk,mp_sk,l_sk,mi_sk)
max(skew_vect)

#quesito 5)

realestate_texas$sales_cl <- cut(realestate_texas$sales , 
                                 breaks= c(75,175,275,375, 475))

N=nrow(realestate_texas)
ni <- table(realestate_texas$sales_cl)
fi <- table(realestate_texas$sales_cl)/N
Ni <- cumsum(ni)
Fi <- Ni/N
cbind(fi, ni, Ni, Fi)


install.packages("ggplot2")
library(ggplot2)

ggplot(data=realestate_texas)+
  geom_bar(aes(x=sales_cl),
           stat="count",
           fill="blue",
           col="red"
  )+
  labs(title="Distribuzione di frequenza della variabile sales",
       x="sales",
       y="conteggio per classe")+
  theme_minimal()


gini.index <- function (x){
  ni=table(x)
  fi=table(x)/length(x)
  fi2=fi^2
  J=length(table(x))
  gini=1-sum(fi2)
  gini.normalizzato = gini/((J-1)/J)
  return(gini.normalizzato)
}
gini.index(realestate_texas$sales)



#quesito 6) Sul documento


#quesito 7) 
#punto 3)
library(dplyr)
data_dec_2012 <- filter(realestate_texas, year==2012, month==12)
p <- nrow(data_dec_2012)/nrow(realestate_texas)

#quesito 8)

realestate_texas$mean <- (realestate_texas$volume/realestate_texas$sales)


#quesito 9)

realestate_texas$effectiveness <- realestate_texas$sales/realestate_texas$listings
max(realestate_texas$effectiveness)

realestate_texas[which(realestate_texas$effectiveness
                       ==max(realestate_texas$effectiveness)), ]
realestate_texas[which(realestate_texas$effectiveness
                       ==min(realestate_texas$effectiveness)), ]

mean(realestate_texas$effectiveness)
var(realestate_texas$effectiveness)
plot(realestate_texas$effectiveness , type="l")

var(realestate_texas[which(realestate_texas$month==1),]$effectiveness)


#quesito 10)

install.packages("dplyr")
library(dplyr)


realestate_texas %>%
  group_by(city) %>%
  summarise(media=mean(sales),
            varianza=var(sales))

realestate_texas %>%
  group_by(city, year) %>%
  summarise(media=mean(sales),
            varianza=var(sales))

realestate_texas %>%
  group_by(city, month) %>%
  reframe(media=mean(sales),
          varianza=var(sales),
          minimo=min(sales),
          massimo=max(sales),
          mediana=median(sales)
  )


realestate_texas %>%
  group_by(city, month) %>%
  reframe(media=mean(median_price),
          varianza=var(median_price),
          minimo=min(median_price),
          massimo=max(median_price),
          mediana=median(median_price)
  )


#quesito 11)

ggplot(data=realestate_texas)+
  geom_boxplot( aes( x= city,
                     y=median_price),
                fill="red",
                outlier.color = "blue"
  )+
  labs(title = "Boxplot prezzo mediano per città" ,
       x="città",
       y="prezzo mediano"
  )+
  theme_bw()

install.packages("moments")
library(moments)


realestate_texas %>%
  group_by(city) %>%
  summarise(asimmetria = skewness(sales)
  )

realestate_texas %>%
  group_by(city) %>%
  summarise(media=mean(median_price),
            varianza=var(median_price),
            minimo=min(median_price),
            massimo=max(median_price),
            mediana=median(median_price)
  )


skewness(realestate_texas$sales)


#quesito 12)

ggplot(data=realestate_texas)+
  geom_boxplot( aes( x= city,
                     y=volume, 
                     fill=factor(year)),
                outlier.color = "blue"
  )+
  labs(title = "Vendite per città e per anno" ,
       x="città",
       y="vendite",
       fill="anni"
  )+
  theme_bw()


#quesito 13)

lista_plot <- list()
colori_personalizzati <- c("#FF5733", "#FFC300",
                           "#33FF33", "#0066CC", "#990099", 
                           "#FFA07A", "#F0E68C", "#C71585", 
                           "#40E0D0", "#FF4500", "#00FF7F", 
                           "#8A2BE2")

a = unique(realestate_texas$year)

for (i in 1:length(a) ){
  lista_plot [[i]] <- ggplot(data=filter(realestate_texas, year == a[i])  )+
    geom_bar( aes(x = city, y = volume, fill = factor(month)     ),
              stat = "identity" , position = "stack" )+
    scale_fill_manual(values = colori_personalizzati)+
    labs(title = paste( "Vendite per città, anno", a[i]) ,
         x="città",
         y="vendite",
         fill="mesi"
    )+
    theme_bw()
}

install.packages("gridExtra")
library(gridExtra)
grid.arrange(lista_plot[[1]], lista_plot[[2]], lista_plot[[3]],
             lista_plot[[4]], lista_plot[[5]],nrow = 2, ncol = 3)


filter( realestate_texas, month==12 )%>%
  group_by(year, city) %>%
  summarise(somma=sum(volume)
  )



#quesito 14)


data_list <- list()
plot_list <- list()


data_list[[1]] <- filter(realestate_texas, year==2010)
data_list[[2]] <- filter(realestate_texas, year==2011)
data_list[[3]] <- filter(realestate_texas, year==2012)
data_list[[4]] <- filter(realestate_texas, year==2013)
data_list[[5]] <- filter(realestate_texas, year==2014)


for (i in 1:length(data_list)){
  year_label <- unique(data_list[[i]]$year)
  
  plot_list[[i]] <- ggplot()+
    geom_line(data=filter(data_list[[i]], city=="Tyler"),
              aes(x=factor(month), y=sales , group=1 , col="Tyler"))+
    geom_point(data=filter(data_list[[i]], city=="Tyler"),
               aes(x=factor(month), y=sales , group=1 , col="Tyler" ))+
    geom_line(data=filter(data_list[[i]], city=="Beaumont"),
              aes(x=factor(month), y=sales , group=1 , col="Beaumont"))+
    geom_point(data=filter(data_list[[i]], city=="Beaumont"),
               aes(x=factor(month), y=sales , group=1 , col="Beaumont" ))+
    geom_line(data=filter(data_list[[i]], city=="Bryan-College Station"),
              aes(x=factor(month), y=sales , group=1 , col="Bryan-College Station"))+
    geom_point(data=filter(data_list[[i]], city=="Bryan-College Station"),
               aes(x=factor(month), y=sales , group=1 , col="Bryan-College Station" ))+
    geom_line(data=filter(data_list[[i]], city=="Wichita Falls"),
              aes(x=factor(month), y=sales , group=1 , col="Wichita Falls"))+
    geom_point(data=filter(data_list[[i]], city=="Wichita Falls"),
               aes(x=factor(month), y=sales , group=1 , col="Wichita Falls" ))+
    labs(title= paste("Vendite, anno" , year_label , sep = " ")  ,
         x="Mese",
         y="Vendite",
         colour="Città"
    )+
    theme_bw()
}



library(gridExtra)
grid.arrange(plot_list[[1]], plot_list[[2]],
             plot_list[[3]], plot_list[[4]], plot_list[[5]] , nrow=3, ncol=2)








