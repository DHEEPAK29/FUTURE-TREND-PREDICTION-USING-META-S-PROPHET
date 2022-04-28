library(wikipediatrend)
data<-wp_trend(page ="MS Dhoni", from="2007-01-01", to="2022-01-01");
View(data)
#wp_cache_reset()

#plot
library(ggplot2)
qplot(date, views, data=data)
summary(data)

# Missing data & Log Transforms
data $ views [data $ views ==0 ] <- NA
ds<- data$date
y<-log(data$views)
df<- data.frame(ds, y)
qplot(ds, y, data= df) #quick plot

# Forecasting with Facebook's Prophet 
library(prophet) #Facebook's core DS team
m<- prophet(df)

#Prediction
future<- make_future_dataframe(m, periods = 1000)
tail(future) # Displays tail end of the future
forecast<-predict(m, future)
tail(forecast)
tail(forecast[c('ds')])

#plot forecast
plot(m, forecast) # time scale forecast
prophet_plot_components(m, forecast) # forecast trend, weekly, yearly
