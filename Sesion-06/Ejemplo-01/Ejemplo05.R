# Cargamos paquetes
# install.packages('reshape')
library(reshape)
library(dplyr)
library(ggplot2)

#Leemos archivo de breast_cancer
breast.cancer <- read.csv('https://raw.githubusercontent.com/analuisaortega/BEDU-R-2020/master/Data/breast_cancer.csv')

# Vemos la estructura
str(breast.cancer)

# Quitamos las columnas no num�ricas
breast.cancer.num <- breast.cancer[  ,-c(1,2,3)]
# Calculamos la matriz de correlaci�n y le damos formato para graficar
cor.df <- melt(cor(breast.cancer.num))
head(cor.df)

# Creamos gr�fico para visualizar matriz de correlaci�n
breast.cancer %>% 
  select(-c(1,2,3)) %>% 
  cor()%>% 
  melt() %>% 
  ggplot(aes(X1,X2)) + 
    geom_tile(aes(fill = value)) + 
    ggtitle('Matriz de correlaci�n') +
    scale_fill_gradient(low = 'white', high = 'red') + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Obtenemos la mediana de la variable radius_mean
median.radius <- median(breast.cancer$perimeter_mean)

# graficamos el histograma y densidad de la variable radius_mean

breast.cancer %>% ggplot(aes(perimeter_mean)) + 
  geom_histogram(colour = 'black', 
                 fill = 'blue', 
                 alpha = 0.5, 
                 binwidth = 3) + 
  ggtitle('Histogram for perimeter mean') + 
  labs(x = 'Radius Mean', y = 'Freq')+
  theme_minimal() +
  geom_vline(xintercept = median(breast.cancer$perimeter_mean), 
             linetype="dashed", 
             color = "red")