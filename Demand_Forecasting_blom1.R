######### Time Series Analysis #########

# Load necessary library for reading Excel files
library(readxl)

# Load the dataset from an Excel file
blom1 <- read_excel("/Users/omerfaruk/Desktop/Demand Forecasting Project/blom1.xlsx")

# Convert the dataset to a data frame and display its class
data.frame(blom1)
class(blom1)

# Remove unnecessary columns from the dataset
blom1$`Running Stock` <- NULL
blom1$`Warehouse Stock` <- NULL

# Convert the Sales column to a time series object
blom1ts <- ts(blom1$Sales, start = c(2012, 1), frequency = 12)
blom1ts

# Plot the time series data
ts.plot(blom1ts, main = "Time Series Plot of blom1", ylab = "Demand")
class(blom1ts)

# Decompose the time series into trend, seasonal, and residual components
decompose(blom1ts)
plot(decompose(blom1ts))

######### Demand Forecasting #########

# Load libraries for forecasting and analysis
library("TTR")
library("forecast")
library("tseries")
library("forecastHybrid")

# Set graphical parameters for multiple plots
par(mfrow = c(3, 2))

# Simple Moving Averages (SMA)
blom1sma <- SMA(blom1ts, n = 2)  # Calculate SMA with a window size of 2
blom1sma
accuracy(blom1sma, blom1ts)  # Evaluate accuracy
plot(blom1sma, main = "Simple Moving Average for blom1", ylab = "Observed/Fitted", col = "red", ylim = c(0, 750))
lines(blom1ts)

# Exponential Moving Averages (EMA)
blom1ema <- EMA(blom1ts, n = 2, ratio = NULL)
blom1ema
accuracy(blom1ema, blom1ts)
plot(blom1ema, main = "Exponential Moving Average for blom1", ylab = "Observed/Fitted", col = "red", ylim = c(0, 750))
lines(blom1ts)

# Double Exponential Moving Averages (DEMA)
blom1dma <- DEMA(blom1ts, n = 4, ratio = NULL)
blom1dma
accuracy(blom1dma, blom1ts)
plot(blom1dma, main = "Double Exponential Moving Average for blom1", ylab = "Observed/Fitted", col = "red", ylim = c(0, 750))
lines(blom1ts)

## Holt-Winters Moving Averages #####

# Simple Exponential Smoothing (SES)
blom1ses <- HoltWinters(blom1ts, beta = FALSE, gamma = FALSE, alpha = 0.26)
blom1ses
accuracy(blom1ses$fitted, blom1ts)
plot(blom1ses, main = "Simple Exponential Smoothing for blom1")
lines(blom1ts)

# Holt's Exponential Smoothing
blom1holt <- HoltWinters(blom1ts, gamma = FALSE, beta = 0.1, alpha = 0.05)
blom1holt
accuracy(blom1holt$fitted, blom1ts)
plot(blom1holt, main = "Holt's Exponential Smoothing for blom1")

# Winter's Exponential Smoothing
blom1win <- HoltWinters(blom1ts, alpha = 0.5, beta = 0.5, gamma = 0.2)
blom1win
accuracy(blom1win$fitted, blom1ts)
plot(blom1win, main = "Winter's Exponential Smoothing for blom1")

###### ARIMA #####

# Test for stationarity
adf.test(blom1ts, alternative = "stationary", k = 16)
ndiffs(blom1ts, test = "adf")  # Find the number of differences needed
nsdiffs(blom1ts)  # Seasonal differencing test

# Plot ACF and PACF
acf(blom1ts)  # Autocorrelation function
pacf(blom1ts)  # Partial autocorrelation function

# Ljung-Box test for randomness
Box.test(blom1ts, lag = 16, type = "Ljung-Box", fitdf = 0)

# Fit an ARIMA model
blom1ts.fit <- arima(blom1ts, order = c(3, 1, 0), include.mean = FALSE)
blom1ts.fit
plot(fitted.values(blom1ts.fit), col = "red", main = "ARIMA(3,1,0) Model for blom1", ylim = c(0, 750))
lines(blom1ts)

# Neural Network Time Series Model
blom1nn <- nnetar(blom1ts)
plot(blom1ts, main = "Neural Network Model for blom1", ylab = "Observed/Fitted")
lines(blom1nn$fitted, col = "red")

### Hybrid Methods ###

# Split data into training and testing sets
blom1train <- window(blom1ts, start = c(2012, 1), frequency = 12, end = c(2014, 8))
blom1test <- window(blom1ts, start = c(2014, 9), frequency = 12)

# Fit hybrid models
blom1hts.fit <- arima(blom1train, order = c(2, 1, 0), include.mean = FALSE)
b1 <- forecast(blom1hts.fit, h = 6)

blom1hnn <- nnetar(blom1train)
c1 <- forecast(blom1hnn, h = 6)

# Hybrid combination model
blom1hyb <- hybridModel(blom1train, models = "an")
a1 <- forecast(blom1hyb, h = 6)

# Validation of models
accuracy(a1, blom1test)
accuracy(b1, blom1test)
accuracy(c1, blom1test)
