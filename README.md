## Introduction
There are many demand forecasting systems in different fields. In this study, we will deal with demand forecasting problem in white goods sector. We will examine past years’ data of certain products that have irregular demands. While we are dealing with problem, we use different types of forecasting methods and compare them each other by using different forecasting accuracy metrics. 
At the same time, we will try to correct the missing data, so that our analysis will become more meaningful. Our goal is to find a meaningful result with one of these methods and thus establish a proper demand forecasting system. By accomplish this we will reduce cost of shipment and stock keeping cost. 

### Forecasting Algorithms:
1. Moving Average (Simple, Exponential and Double Exponential)
2. Simple Exponential Smoothing
3. Holt's Method (Adjusted for trend)
4. Winter's Method (Adjusted for trend and seosinal variation)
5. ARIMA
6. Neural Network (NN)
7. Hybrid Model (ARIMA and NN)
8. Augmented Dickey Fuller Test (for ARIMA)

### Data set:
Time series data with 38 months of production, sales and stock level. 
There are two different types of products named blom1 and blom2. Same code file can be run for both of the products by changing target file name in Demand_Forecasting.R 
* Validation: %30
* Accuracy Test Techniques: RMSE, MAE, MAPE

### Notes:

