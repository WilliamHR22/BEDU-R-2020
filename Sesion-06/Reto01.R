library(plotly)
library(reshape)
library(dplyr)
library(ggplot2)

############ Reto 1 ##################

# Lee el archivo Metro_Interstate_Traffic_Volume.csv
# Ve la estructura del dataframe
# Encuentra la matriz de correlaci�n de las variabes 
# num�ricas continuas 'temp','rain_1h','snow_1h','clouds_all','traffic_volume'.
# Crea una visualizaci�n en d�nde las correlaciones 
# m�s fuertes tengan color negro y las correlaciones 
# m�s d�biles tengan color blanco
# Viendo la gr�fica que creaste o la matriz de correlaci�n,
# responde: �Cu�les son las dos variables m�s correlacionadas? 
# �La correlaci�n es positiva o negativa?

df_metro <- read.csv('https://raw.githubusercontent.com/analuisaortega/BEDU-R-2020/master/Data/Metro_Interstate_Traffic_Volume.csv')

str(df_metro)

df_metro %>% 
  select(temp, rain_1h, snow_1h, clouds_all, traffic_volume) %>% 
  cor() %>% 
  melt() %>% 
  ggplot(aes(X1,X2)) + 
  geom_tile(aes(fill = value)) +
  ggtitle('Matriz de correlaci�n') +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_gradient(low = 'white', high = 'black') 
# las variables con correlaci�n m�s fuerte son temp y traffic_volumne
# y es positiva

# Reto Bonus:
# Cambiar de gr�fico de ggplot2 a gr�fico interactivo de plotly
my_plot <- df_metro %>% 
  select(temp, rain_1h, snow_1h, clouds_all, traffic_volume) %>% 
  cor() %>% 
  melt() %>% 
  ggplot(aes(X1,X2)) + 
  geom_tile(aes(fill = value)) +
  ggtitle('Matriz de correlaci�n') +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_gradient(low = 'white', high = 'black') 

ggplotly(my_plot)

######### Reto 2 ##############
# Ve la estructura del dataframe (es factor?)
# �Cu�les son los niveles de la columna weather_main?
# Crea un histograma para la variable traffic_volume
# Agrega formato al histograma: 
# titulo, nombre a los ejes, color de barras amarillo
# Utiliza facet_wrap con la variable weather_main 
# para separar los histogramas por tipo de clima
str(df_metro)

df_metro$weather_main <- as.factor(df_metro$weather_main)

df_metro %>% 
  ggplot(aes(traffic_volume)) + 
  geom_histogram(colour = 'yellow', 
                 alpha = 0.5, 
                 binwidth = 1) + 
  ggtitle('Histogram for traffic volume') + 
  labs(x = 'Traffic Volume', y = 'Frequency') +
  theme_minimal() +
  facet_wrap('weather_main')

# Reto bonus: pasarlo a gr�fico interactivo de ggplotly
my_plot_2 <- df_metro %>% 
  ggplot(aes(traffic_volume)) + 
  geom_histogram(colour = 'black', 
                 fill = 'yellow', 
                 alpha = 0.5, 
                 binwidth = 3) + 
  ggtitle('Histogram for traffic volume') + 
  labs(x = 'Traffic Volume', y = 'Frequency') +
  theme_minimal() +
  facet_wrap('weather_main')

ggplotly(my_plot_2)
