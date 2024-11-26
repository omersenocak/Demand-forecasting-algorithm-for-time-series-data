#########Time Series Analysis#########
library(readxl)
blom1 <- read_excel("/Users/omerfaruk/Desktop/Demand Forecasting Project/blom1.xlsx")
data.frame(blom1)
class(blom1)
blom1$`Running Stock`<-NULL
blom1$`Warehouse Stock`<-NULL
blom1ts<-ts(blom1$Sales,start = c(2012,1),frequency = 12)
blom1ts
ts.plot(blom1ts,main="Time Series Plot of blom1",ylab="Demand")
class(blom1ts)
decompose(blom1ts)
plot(decompose(blom1ts))
########Demand Forecasting#########
library("TTR")
library("forecast")
library("tseries")
library("forecastHybrid")
par(mfrow = c(3, 2))
blom1sma<-SMA(blom1ts,n=2)  #Simple Moving Averages
blom1sma
accuracy(blom1sma,blom1ts)
plot(blom1sma,main="Simple Moving Average for blom1",ylab="Observed/Fitted",col="red",ylim=c(0,750))
lines(blom1ts)
blom1ema<-EMA(blom1ts,n=2, ratio = NULL)  #Exp. Moving Averages
blom1ema
accuracy(blom1ema,blom1ts)
plot(blom1ema,main="Exponential Moving Average for blom1",ylab="Observed/Fitted",col="red",ylim=c(0,750))
lines(blom1ts)
blom1dma<-DEMA(blom1ts,n=4, ratio = NULL) # Double Exp. Moving Average
blom1dma
accuracy(blom1dma,blom1ts)
plot(blom1dma,main="Double Exp. Moving Average for blom1",ylab="Observed/Fitted",col="red",ylim=c(0,750))
lines(blom1ts)

##Holts-Winter Moving Averages#####
#notes: Beta = False and Gamma = False gives Ewma
#       Beta = False gives Double Exponential Somoothing
blom1ses<-HoltWinters(blom1ts,beta = FALSE,gamma = FALSE,alpha = 0.26)
blom1ses
accuracy(blom1ses$fitted,blom1ts)
plot(blom1ses,main="Simple Exponential Smoothing for blom1")
lines(blom1ts)
blom1ses$fitted
blom1holt<-HoltWinters(blom1ts,gamma = FALSE,beta = 0.1,alpha = 0.05)
blom1holt
accuracy(blom1holt$fitted,blom1ts)
plot(blom1holt,main="Holt's Exponential Smoothing for blom1")
blom1holt$fitted
blom1win<-HoltWinters(blom1ts,alpha = 0.5,beta = 0.5,gamma = 0.2)
blom1win
accuracy(blom1win$fitted,blom1ts)
plot(blom1win,main="Winter's Exponential Smoothing for blom1")
blom1win$fitted
accuracy(blom1sma,blom1ts)
accuracy(blom1ema,blom1ts)
accuracy(blom1dma,blom1ts)
accuracy(blom1ses$fitted,blom1ts)
accuracy(blom1holt$fitted,blom1ts)
accuracy(blom1win$fitted,blom1ts)
######Arima#####
adf.test(blom1ts,alternative="stationary", k=16) #stationarity test
ndiffs(blom1ts,test = "adf") #number of diff. for required to be made stationary
nsdiffs(blom1ts)
#Plot acf and pacf on the same graph
#par(mfrow=c(2,1))
acf(blom1ts)  #autocorrelation of function
pacf(blom1ts) #partial auto correlation of function
Box.test(blom1ts, lag = 16, type = "Ljung-Box", fitdf = 0)
#Fit the Model
blom1ts.fit<-auto.arima(blom1ts)
blom1ts.fit<-arima(blom1ts,order = c(3,1,0),include.mean = FALSE)
blom1ts.fit
fitted.values(blom1ts.fit)
residuals(blom1ts.fit)
plot(blom1ts.fit,main="Inverse AR Roots for Blom1")
plot(fitted.values(blom1ts.fit),col="red",main="ARIMA(3,1,0) Model forBlom1",ylim=c(0,750))
lines(blom1ts)
blom1nn<-nnetar(blom1ts)
blom1nn
accuracy(blom1nn)
fitted.values(blom1nn)
summary(blom1nn)
plot(blom1ts,main="Neural Network Model for blom1",ylab="Observed/Fitted")
lines(blom1nn$fitted,col="red")
accuracy(blom1ts.fit)
accuracy(blom1ts)
accuracy(blom1nn)
###Hybrid methods###
blom1train<-window(blom1ts,start = c(2012,1),frequency = 12,end = c(2014,8))
blom1train
blom1test<-window(blom1ts,start = c(2014,9),frequency = 12)
blom1test
blom1hts.fit<-auto.arima(blom1train)
blom1hts.fit<-arima(blom1train,order = c(2,1,0),include.mean = FALSE)
blom1hts.fit
fitted.values(blom1hts.fit)
residuals(blom1hts.fit)
plot(forecast(blom1hts.fit))
b1<-forecast(blom1hts.fit,h=6)
b1
blom1hnn<-nnetar(blom1train)
blom1hnn
accuracy(blom1hnn)
fitted.values(blom1hnn)
summary(blom1hnn)
c1<-forecast(blom1hnn,h=6)
c1
blom1hyb<-hybridModel(blom1train,models="an")
blom1hyb
plot(forecast(blom1hyb))
plot(blom1hyb, type = "fit")
a1<-forecast(blom1hyb,h=6)
a1
plot(blom1hyb$fitted,main="Hybrid model for blom1",col="red",ylim=c(0,900),ylab="Observed/Fitted")
lines(blom1train)
blom1hann<-nnetar(blom1hts.fit$residuals)
blom1hann
accuracy(blom1hann)
fitted.values(blom1hann)
summary(blom1hann)
forecast(blom1hann,h=6)
accuracy(a1,blom1test)
accuracy(b1,blom1test)
accuracy(c1,blom1test)
cvblom1 <- cvts(blom1ts, FUN = hybridModel,
                FCFUN = forecast, windowSize = 32,
                maxHorizon = 12)
###Validation###
blom1sests<-ts(blom1$Sales,start = c(2012,1),frequency = 12)
blom1sests
blom1sestrain<-window(blom1sests,start = c(2012,1),frequency = 12,end = c(2014,8))
blom1sestrain
blom1sestest<-window(blom1sests,start = c(2014,9),frequency = 12)
blom1sestest
blom1hybsa<-auto.arima(blom1sestrain)
blom1hybsa
d1<-forecast(blom1hybsa,h=6)
d1
accuracy(d1,blom1test)
