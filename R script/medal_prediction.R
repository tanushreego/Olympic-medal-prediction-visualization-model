library("gganimate")
library("data.table")
library("knitr")
library("gridExtra")
library("tidyverse")
library("plotly")
library("ggplot2")

medals <- read.csv("/Users/tanushree/Desktop/FDA PROJECT/datasets/medal_pop_gdp_data_statlearn.csv")
summary(medals)

#model
loglikeli <- rep(NA,4)
df_for_model <- medals[,c(2,3,5)]
colnames(df_for_model) <- c("GDP","Popltn","medals")
model_1 <- glm(formula = medals ~ GDP + Popltn , data =  df_for_model)
summary(model_1)

#prediction
df_test <- medals[,c(2,3)]
colnames(df_test) <- c("GDP","Popltn")

act_vs_pred_1 <- data.frame(country = medals$Country, GDP = medals$GDP, 
                            Pop = medals$Population, act = medals$Medal2016, 
                            pred=ceiling(predict(model_1,newdata = df_test)))
act_vs_pred_1$diff <- abs(act_vs_pred_1$pred - act_vs_pred_1$act)

# CI for task 1:
mod1_coeff <- summary(model_1)$coefficients[,1:2]
mod1_coeff
CI_Interval_min <- mod1_coeff[1,1] - mod1_coeff[1,2]* (qt(p=0.975, df=67))
CI_Interval_max <- mod1_coeff[1,1] + mod1_coeff[1,2]* (qt(p=0.975, df=67)) 
# CI_Intercept <- [3.08,9.07]

CI_GDP_min <- mod1_coeff[2,1] - mod1_coeff[2,2]* (qt(p=0.975, df=67))
CI_GDP_max <- mod1_coeff[2,1] + mod1_coeff[2,2]* (qt(p=0.975, df=67)) 
# CI_GDP <- [6.101*10^{-3},9.026*10^{-3}]

CI_pop_min <- mod1_coeff[3,1] - mod1_coeff[3,2]* (qt(p=0.975, df=67))
CI_pop_max <- mod1_coeff[3,1] + mod1_coeff[3,2]* (qt(p=0.975, df=67))
# CI_pop <- [-9.109*10^{-9},1.96.026*10^{-8}]

# Plot 
ggplot(data = act_vs_pred_1,mapping = aes(log(act),log(pred),color = diff)) +
  geom_point()+
  geom_text(mapping = aes(log(act),log(pred),label = country), 
            data = act_vs_pred_1[act_vs_pred_1$diff >10 ,] )+
  geom_abline(intercept=0, slope=1, color='maroon', size=0.6)+ 
  ggtitle('Actual vs Predicted medal count for 2016 Olympics') +
  xlab('Actual_2016 medal Count') +
  xlim(0,5)+
  ylim(0,5)+
  ylab('Predicted 2016 medal count')

#####################################
############## TASK 2 ###############
#####################################

# model
model_2 <- glm(formula = log(medals) ~ GDP + Popltn , data = df_for_model )

#prediction 
act_vs_pred_2 <- data.frame(country = medals$Country, GDP = medals$GDP, 
                            Pop = medals$Population, act = medals$Medal2016, 
                            pred=ceiling(exp((predict(model_2,newdata = df_test)))))
act_vs_pred_2$diff <- abs(act_vs_pred_2$pred - act_vs_pred_2$act)

# plot
library(ggplot2)
ggplot(data = act_vs_pred_2,mapping = aes(log(act),log(pred),color = diff)) +
  geom_point()+
  geom_text(mapping = aes(log(act),log(pred),label = country), 
            data = act_vs_pred_2[act_vs_pred_2$diff >10 ,],
            position=position_jitter(width=1,height=1.5))+
  geom_abline(intercept=0, slope=1, color='maroon', size=0.6)+ 
  ggtitle('Actual vs Predicted medal count for 2016 Olympics') +
  xlab('Actual_2016 medal Count') +
  xlim(0,5)+
  ylim(0,5)+
  ylab('Predicted 2016 medal count')

#####################################
############## TASK 3 ###############
#####################################

# model
model_3 <- glm(formula = medals ~ GDP + Popltn , 
               data = df_for_model  ,
               family = poisson(link = "log"))

# CI for task 3:
mod3_coeff <- summary(model_3)$coefficients[,1:2]
mod3_coeff
CI_Interval_min <- mod3_coeff[1,1] - mod3_coeff[1,2]* (qt(p=0.975, df=67))
CI_Interval_max <- mod3_coeff[1,1] + mod3_coeff[1,2]* (qt(p=0.975, df=67)) 
# CI_Intercept <- [2.11,2.27]

CI_GDP_min <- mod3_coeff[2,1] - mod3_coeff[2,2]* (qt(p=0.975, df=67))
CI_GDP_max <- mod3_coeff[2,1] + mod3_coeff[2,2]* (qt(p=0.975, df=67)) 
# CI_GDP <- [1.58*10^{-4},1.84*10^{-4}]

CI_pop_min <- mod3_coeff[3,1] - mod3_coeff[3,2]* (qt(p=0.975, df=67))
CI_pop_max <- mod3_coeff[3,1] + mod3_coeff[3,2]* (qt(p=0.975, df=67))
# CI_pop <- [4.22*10^{-10},8.87*10^{-10}]

#prediction
act_vs_pred_2 <- data.frame(country = medals$Country, GDP = medals$GDP, 
                            Pop = medals$Population, act = medals$Medal2016, 
                            pred=ceiling(exp((predict(model_2,newdata = df_test)))))
act_vs_pred_2$diff <- abs(act_vs_pred_2$pred - act_vs_pred_2$act)

# plot
library(ggplot2)
ggplot(data = act_vs_pred_2,mapping = aes(log(act),log(pred),color = diff)) +
  geom_point()+
  geom_text(mapping = aes(log(act),log(pred),label = country), 
            data = act_vs_pred_2[act_vs_pred_2$diff >10 ,],
            position=position_jitter(width=1,height=1.5))+
  geom_abline(intercept=0, slope=1, color='maroon', size=0.6)+ 
  ggtitle('Actual vs Predicted medal count for 2016 Olympics') +
  xlab('Actual_2016 medal Count') +
  xlim(0,5)+
  ylim(0,5)+
  ylab('Predicted 2016 medal count')

#####################################
############## TASK 4 ###############
#####################################

#model
library(MASS)
model_4 <- glm.nb(formula = medals ~ GDP + Popltn , 
                  data = df_for_model)
summary(model_4)

model_4_2 <- glm(formula = medals ~ GDP + Popltn, 
                 data = df_for_model, 
                 family = negative.binomial(theta = 1.547))

#calculating loglikelihoods for theta from 0.001 to 1000
n <- 100

loglikelihood <-function(thetav){
  model_4_1 <- glm(formula = medals ~ GDP + Popltn, 
                   data = df_for_model, 
                   family = negative.binomial(theta = thetav))
  loglike <- logLik(model_4_1)
  return(loglike)
}

loglike <- rep(NA,n)
thetaval <- seq(0.001 ,1000, length.out =n)
for (i in 1:n) {
  loglike[i] <- loglikelihood(thetaval[i])
  
}

plot(thetaval,loglike)
abline(v=1.547,col = "green")

#####################################
############## TASK 5 ###############
#####################################

loglikeli[1] <- logLik(model_1)
loglikeli[2] <- logLik(model_2)
loglikeli[3] <- logLik(model_3)
loglikeli[4] <- logLik(model_4)

x <- seq(1,4 ,by= 1)
ggplot(mapping = aes(x,loglikeli)) +
  geom_point(size = 3)+
  geom_line(color = "skyblue")+
  ggtitle("loglikelihood values plotted for each model" )+
  xlab("models 1,2,3 & 4")+
  ylab("Maximum Loglikehood values")