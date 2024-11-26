## Introduction
Demand forecasting is a critical component of decision-making across numerous industries, ensuring efficient inventory management, optimized supply chains, and cost savings. This project focuses on tackling the challenge of demand forecasting in the white goods sector, where certain products exhibit irregular demand patterns.

Using historical sales data, we explore and apply a variety of forecasting methods, comparing their performance using key accuracy metrics. Our approach also addresses missing data issues to improve the quality and reliability of the analysis. By identifying the most effective forecasting model, we aim to design a robust demand forecasting system that minimizes shipment and inventory holding costs while enhancing operational efficiency.

This project not only provides insights into demand trends but also offers a practical framework for solving real-world forecasting problems in industries where demand patterns are highly variable.

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
You can find more explanations about ARIMA model and parameter selection in 'ARIMA_Minitab_Results' file. 
