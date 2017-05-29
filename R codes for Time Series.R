##########################
### Time Series with R ###
##########################

start(Nile)
end(Nile)
frequency(Nile)

frequency(AirPassengers) #number of observations per unit time
time(AirPassengers)
deltat(AirPassengers) #fixed time interval between observations
cycle(AirPassengers)
length(AirPassengers)

#plot time series
plot(Nile, xlab = "Year", ylab = "River Volume", main = "Annual River Nile Volume at Aswan, 1871-1970")

#
ts(c(14,13,12,10,12,11,10,12,11,13,14), start = 2000, frequency = 1) %>% plot()

ts.plot(EuStockMarkets, col = 1:4)

### data transformations
log(TS) #natural log: linearize rapid growth trend, stabilize series that exhibit increasing variance (heteroskedasticity?), limitation is can work only with positive values
diff(TS) #differencing: changes between consecutive series, one fewer observations
diff(TS, lag = 4) #seasonal differecing: correct seasonal pattern

### WHITE NOISE
# properties: 1) fixed, constant mean, 2) fixed, constant variance, 3) no correlation over time
TS <- arima.sim(model = list(order = c(0, 0, 0)), n = 50, mean = 4, sd = 2) #simulate a white noise time series. default mean=4, sd=2
ts.plot(TS)

# estimate white noise (WN) TS model
arima(TS, order = c(0, 0, 0)) #returns intercept (mean), standard error (s.e.) and variance (sigma^2)
# we can use mean() and var() to calculate sample mean and variance, and compare them with above. In the case of WN, they should be very close
mean(TS)
var(TS)

### RANDOM WALK (RW): (non-stationary)
# properties: 1) No specified mean or variance, 2) strong dependence over time, 3) its changes or increments are WN, which stable and stationary
# The random walk (RW) model is a special case of the autoregressive (AR) model, in which the slope parameter is equal to 1
# random walk model: T-oday = Y-esterday + N-oise
# or: Y_t = Y_t-1 + e_t   >> e_t is WN
# diff(RW) = WN
arima.sim(model = list(order = c(0,1,0)), n = 50) %>% ts.plot

# estimate random walk (RW)
WN <- diff(RW)
model_wn <- arima(WN, order = c(0,0,0))
int_wn <- model_wn$coef
ts.plot(WN)
abline(0, int_wn)

ts.plot(cbind(WN, RW))

plot(a, b) #scatter plot
pairs(EuStockMarkets) #scatter plot matrix

cor(ts_df)
cor(var1, var2) #cov(var1,var2)/(sd(var)*sd(var2))

### autocorrelation
acf(Nile, plot = F, lag.max = 1)
cor(Nile[-(99:100)], Nile[-(1:2)]) #cor(Nile[-(99:100)], Nile[-(1:2)]) * (100-1)/100
acf(Nile, plot = T)


### Autoregressive (AR) processes: similar to simple linear regression, but in AR each observation is regressed on the previous observation
# Y_t = C + b*Y_t-1 + e
# mean centered version: (Y_t - mean) = b*(Y_t-1 - mean) + e
arima.sim(model = list(ar = 0.5), n = 100) %>% ts.plot() #simulate an AR process. argument "ar" is amount of autocorrelation or slope parameter, and gets values between 1 and -1
arima.sim(model = list(ar = 0.5), n = 100) %>% acf() #estimate autocorrelation of the simulated AR process

# AR Model estimation example
dt <- arima.sim(model = list(ar = 0.8), n = 100) #simulate series
ar_dt <- arima(dt, order = c(1,0,0)) # estimate AR(1) process
print(ar_dt) #AR(1) result is below
# Call:
# arima(x = ., order = c(1, 0, 0))
# 
# Coefficients:
#          ar1  intercept
#       0.7793    -0.0043
# s.e.  0.0610     0.4273
# 
# sigma^2 estimated as 0.9521:  log likelihood = -139.91,  aic = 285.81
# > > > >  RESULTS: slope coef = 0.7793, intercept (mean) = -0.0043, innovation variance (sigma^2) = 0.9521 < < < <
ts.plot(dt) #plots the series
fitted_dt <- dt - residuals(ar_dt) #function residuals() extracts the residual from model. subtracting it from dt, we get fitted values
points(fitted_dt, type = "l", col = "red", lty = 2) #adds dashed line of fitted values to the series
predict(ar_dt, n.ahead = 5) #predict 5 periods ahead using estimates of the model

# example prediction of Nile time series
predNile <- arima(Nile, order = c(1,0,0)) %>% predict(n.ahead = 10) #estimate AR(1) process, and predict 10 periods
ts.plot(Nile, xlim = c(1871, 1980)) #plot the series, with additional 10 years using xlim
points(predNile$pred, type = "l", col = 2) #adds the prediction
points(predNile$pred + predNile$se*2, type = "l", col = 2, lty = 2) #adds the 95% CI upper bound
points(predNile$pred - predNile$se*2, type = "l", col = 2, lty = 2) #adds the 95% CI lower bound

#


























### <<>>> [GENERAL NOTES] <<<>>

### << Autoregression >> 

#Simulate the autoregressive model
#   The autoregressive (AR) model is arguably the most widely used time series model. It shares the very familiar interpretation of a simple linear regression, but here each observation is regressed on the previous observation. The AR model also includes the white noise (WN) and random walk (RW) models examined in earlier chapters as special cases.
#   The versatile arima.sim() function used in previous chapters can also be used to simulate data from an AR model by setting the model argument equal to list(ar = phi) , in which phi is a slope parameter from the interval (-1, 1). We also need to specify a series length n.
#   In this exercise, you will use this command to simulate and plot three different AR models with slope parameters equal to 0.5, 0.9, and -0.75, respectively.

#Estimate the autocorrelation function (ACF) for an autoregression
#   What if you need to estimate the autocorrelation function from your data? To do so, you'll need the acf() command, which estimates autocorrelation by exploring lags in your data. By default, this command generates a plot of the relationship between the current observation and lags extending backwards.
#   In this exercise, you'll use the acf() command to estimate the autocorrelation function for three new simulated AR series (x, y, and z). These objects have slope parameters 0.5, 0.9, and -0.75, respectively, and are shown in the adjoining figure.

#Persistence and anti-persistence
#   Autoregressive processes can exhibit varying levels of persistence as well as anti-persistence or oscillatory behavior. Persistence is defined by a high correlation between an observation and its lag, while anti-persistence is defined by a large amount of variation between an observation and its lag.

#Compare the random walk (RW) and autoregressive (AR) models
#   The random walk (RW) model is a special case of the autoregressive (AR) model, in which the slope parameter is equal to 1. Recall from previous chapters that the RW model is not stationary and exhibits very strong persistence. Its sample autocovariance function (ACF) also decays to zero very slowly, meaning past values have a long lasting impact on current values.
#   The stationary AR model has a slope parameter between -1 and 1. The AR model exhibits higher persistence when its slope parameter is closer to 1, but the process reverts to its mean fairly quickly. Its sample ACF also decays to zero at a quick (geometric) rate, indicating that values far in the past have little impact on future values of the process.
#   In this exercise, you'll explore these qualities by simulating and plotting additional data from an AR model.

#Estimate the autoregressive (AR) model
#   For a given time series x we can fit the autoregressive (AR) model using the arima() command and setting order equal to c(1, 0, 0). Note for reference that an AR model is an ARIMA(1, 0, 0) model.
#   In this exercise, you'll explore additional qualities of the AR model by practicing the arima() command on a simulated time series x as well as the AirPassengers data. This command allows you to identify the estimated slope (ar1), mean (intercept), and innovation variance (sigma^2) of the model.

#Estimate the autoregressive (AR) model
#   For a given time series x we can fit the autoregressive (AR) model using the arima() command and setting order equal to c(1, 0, 0). Note for reference that an AR model is an ARIMA(1, 0, 0) model.
#   In this exercise, you'll explore additional qualities of the AR model by practicing the arima() command on a simulated time series x as well as the AirPassengers data. This command allows you to identify the estimated slope (ar1), mean (intercept), and innovation variance (sigma^2) of the model.

#Simple forecasts from an estimated AR model
#   Now that you've modeled your data using the arima() command, you are ready to make simple forecasts based on your model. The predict() function can be used to make forecasts from an estimated AR model. In the object generated by your predict() command, the $pred value is the forceast, and the $se value is the standard error for the forceast.
#   To make predictions for several periods beyond the last observations, you can use the n.ahead argument in your predict() command. This argument establishes the forecast horizon (h), or the number of periods being forceast. The forecasts are made recursively from 1 to h-steps ahead from the end of the observed time series.
#   In this exercise, you'll make simple forecasts using an AR model applied to the Nile data, which records annual observations of the flow of the River Nile from 1871 to 1970.




# financial metrices: daily net returns, daily log returns




