# ARIMA Model Settings and Results

## Overview  
In this section, we apply ARIMA, an advanced forecasting technique, to analyze and predict demand for products with irregular time series patterns. Using an iterative model-building approach, we identify and estimate appropriate ARIMA models for our product, Blom1, and use these models to generate forecasts. 

## ARIMA Model for Blom1  

![image](https://github.com/user-attachments/assets/9dd94413-9d75-4601-8b14-956386d004f1)


### Stationarity  
The time series of Blom1 is not stationary, so we applied differencing. To determine the differencing order, we analyzed the ACF and PACF values.

#### ACF and PACF Lag Values  
**ACF**

![image](https://github.com/user-attachments/assets/c909b2d9-7b88-44ab-822b-6d0112fcdaa7) ![image](https://github.com/user-attachments/assets/b28e54a3-47a5-49bc-82a7-da7c707a7a80)

**PACF**  

![image](https://github.com/user-attachments/assets/c38a0bac-e0c6-4500-88b8-5b1c23b2a678) ![image](https://github.com/user-attachments/assets/18390888-8c07-4055-9191-ab7ac5d04397)

From the ACF and PACF graphs, the first lag showed significant correlation. As a result, ARIMA(1,1,0) was selected as an initial model.  

---

## Iterative Model Building  

### ARIMA(1,1,0)  
The table below shows the parameter estimates at each iteration:  
![image](https://github.com/user-attachments/assets/60099ca5-7a21-46a5-9ea9-d8f5f57cb2fe)

#### Final Parameter Estimates 
![image](https://github.com/user-attachments/assets/fec6a83f-4b05-4e0e-a08c-ef6acf24a5d3) ![image](https://github.com/user-attachments/assets/b3f39472-ea22-4096-90fa-078eb4332eff)

---

### ARIMA(2,1,0)  
After adjusting for a second lag, ARIMA(2,1,0) was tested. Key results include: 

![image](https://github.com/user-attachments/assets/f6afc485-111a-4a68-b21c-3e68d3f6c676)


#### Final Parameter Estimates  

![image](https://github.com/user-attachments/assets/0e3f289d-19f9-4cc9-9add-17379a7bc418)
![image](https://github.com/user-attachments/assets/b15a8644-fed0-4e23-b919-4e37ca4cefb6)

---

### ARIMA(3,1,0)  
Finally, ARIMA(3,1,0) was evaluated as the residuals became uncorrelated:  
![image](https://github.com/user-attachments/assets/d3e67d82-5201-455a-814f-f1b1b7855de6)


#### Final Parameter Estimates  

![image](https://github.com/user-attachments/assets/d107d4fd-c027-400b-9743-9d6c4e0b8514)
![image](https://github.com/user-attachments/assets/ba4ee315-5ffc-4c06-8773-53d64c55d749)

### Residual Analysis  
Residual plots confirmed that assumptions were met, and the model was finalized as ARIMA(3,1,0).

![image](https://github.com/user-attachments/assets/8a03ed3f-41fc-473c-8eda-4c761473dfd9)


---

## Forecasting Results  
Using ARIMA(3,1,0), a six-month forecast was generated:  


| Period Forecast  |   Lower  |  Upper  | Actual |
|---|---|---|---|
|    39            | 216,066  |-130,064 | 562,196|
|    40            | 271,009  |-111,302 | 653,319|
|    41            | 210,152  |-181,731 | 602,035|
|    42            | 151,398  |-246,030 | 548,826|
|    43            | 198,721  |-244,469 | 641,910|
|    44            | 239,759  |-235,195 | 714,714|



---

## Conclusion  
ARIMA proved effective for demand forecasting, representing both stationary and nonstationary time series. The methodology successfully modeled Blom1's irregular demand pattern and produced reliable forecasts. This analysis used Minitab for evaluating ACF and PACF, determining differencing order, and estimating parameters.  



