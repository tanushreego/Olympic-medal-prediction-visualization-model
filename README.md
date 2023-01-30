# Olympic-medal-prediction-visualization-model
Abstract:
To find out which countries have won the most medals and how the participation of nations has changed over the time, with R. This is also to predict the most recent results of the Olympic Games using various machine techniques. The most important benefit of visual analytics is that it makes complex data easier to interpret while presenting it in a clear, succinct, and suitable manner. This project presents a useful visual analysis of the Olympic games from 1896 to 2016. This project claims to give an efficient, effective, functional, and convenient model by utilising concrete analysis examples.

The main purpose is to demonstrate how we can benefit from the built system’s visual representations. While informing people about the Olympics, user interfaces are very important and are simple, and easy to make with RStudio.

The main questions to this project are: Which countries are the most dominant? How has involvement evolved? Which countries have the most medals in various disciplines? What is the ratio of female/male Olympic attendees? What will be the most probable result of next years olympic?

To answer the main question, a data set from Kaggle was chosen, which consists of three distinct tables : athleteEvents.csv, medal_pop_gdp_data_statlearn.csv and nocRegions.csv.

athleteEvents.csv : https://www.kaggle.com/datasets/heesoo37/120-years-of-olympic-history-athletes-and-results
medal_pop_gdp_data_statlearn.csv and nocRegions.csv : in the dataset folder.

This study was done by collecting the data for 2008, 2012 and 2016 Olympics data. The countries that had won at least one gold medal are considered. The data consists of 71 countries and the features are country name, its GDP and population and the medals won at 2008,2012 and 2016 Olympics.

To create the visualisations we will use three different data frames. After reviewing the dataset, it was decided not to eliminate any data and instead to use the dplyr package to manipulate and alter the data to make it more applicable and realistic. 

Various libraries were used which helped to interpret the data such as library(“gganimate”), library(“data.table”), library(“knitr”), library(“gridExtra”), library(“tidyverse”), library(“plotly”), library(“ggplot2").

For prediction of the Olympic medals we have made four models using different algorithm and selected the model which predicts the medals most similar to the medal won by the countries in actual Olympics.
The algorithm used are:

Linear Regression Model,
Linear transform to log transformed value,
Poisson Regression,
Negative Binomial Regression,
