#########Time Series Analysis#########
library(readxl)
blom1 <- read_excel("C:/Users/ömer faruk/Desktop/Bitirme Pojesi/Products/Blom/7658839571-B1.xlsx")


data.frame(blom1)
class(blom1)
blom1 <- blom1[,-(1:10),drop=FALSE]
blom1$`Devreden Stok`<-NULL
blom1$`Depo Stoku`<-NULL


blom1ts<-ts(blom1$Satýþlar,start = c(2013,2),frequency = 12)
blom1ts
ts.plot(blom1ts,main="Time Series Plot of Bloomberg(DWT54100)",ylab="Demand")

class(blom1ts)
blom1ts

decompose(blom1ts)
plot(decompose(blom1ts))

########Demand Forecasting#########

SMA(blom1ts,n=1)



##Holts-Winter Moving Averages#####
blom1holt<-HoltWinters(blom1ts)
                      # alpha = 0.8, 
                       #beta = 0,
                      # gamma = 0.1
                       

#notes: Beta = False and Gamma = False gives Ewma
#       Beta = False gives Double Exponential Somoothing


blom1holt

blom1holtp<-predict(blom1holt,n.ahead=6,prediction.interval=TRUE)
blom1holtp

blom1holt$fitted
plot.ts(blom1ts,xlim=c(2013,2017),ylim = c(0,800),ylab="Demand")
lines(blom1holt$fitted[,1],col="Green")
lines(blom1holtp[,1],col="Blue")
lines(blom1holtp[,2],col="Red")

lines(blom1holtp[,3],col="Red")

######Arima####
summary(blom1ts)
#Plot acf and pacf on the same graph
par(mfrow=c(2,1))
acf(blom1ts)  #autocorrelation of function
pacf(blom1ts) #partial auto correlation of function

Box.test(blom1ts, lag = 16, type = c("Box-Pierce", "Ljung-Box"), fitdf = 0)



#differennces the series and plot it
dblom1ts<- diff(blom1ts)
ndblom1ts<- length(dblom1ts)

plot(1:ndblom1ts,dblom1ts,type = "l")

par(mfrow=c(2,1))
acf(dblom1ts) 
pacf(dblom1ts)

#Fit the Model
blom1ts.fit<- arima(blom1ts,order = c(0,0,0),
                   seasonal = list(order=c(1,1,1),period=12),
                   include.mean = FALSE)
blom1ts.fit

#Generate Predictions
blom1ts.pred<-predict(blom1ts.fit,n.ahead=6)
blom1ts.pred

plot(blom1ts,type= "l",xlim=c(2014,2016),ylim=c(0,50))
lines(blom1ts.pred$pred,col="BLUE")
lines(blom1ts.pred$pred+2*blom1ts.pred$se,col="RED")
lines(blom1ts.pred$pred-2*blom1ts.pred$se,col="RED")


lblom1ts<-log(blom1ts)
t<-seq(2013.2,2015.2,length=length(blom1ts))
t2<-t^2
plot(lblom1ts)
lm(lblom1ts~t+t2)
lines(lm(lbeer~t+t2)$fit,col=2,lwd=2)


