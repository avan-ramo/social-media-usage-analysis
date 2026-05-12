# R Project - Analyzing Social Media Usage
# Omar Nava

##############
# Introduction
##############
# Social Media has become an integral part of modern life in terms of communication
# and keeping up with others. Understanding the impact that different social 
# media platforms can have on users can help provide insight onto creating 
# boundaries for ourselves when it comes to utilizing them. The purpose of this 
# study is to analyze social media media usage with emotional well-being along 
# with verifying if there are any relationships between daily usage among age 
# categorized by gender. 

#############
# Methodology 
#############
# The analysis for this study was conducted using R, in particular utilizing the
# libraries dplyr for data manipulation and ggplot2 for visualizing the data.
# The study includes:
# 1. Identifying the most common emotions associated with each platform.
# 2. Ranking the platforms based on total time spent along with average daily
#    time spent.
# 3. Analyzing the most common platforms for each gender.
# 4. Examining if there's a correlation between daily usage time and age, 
#    categorizing by different genders.

##########
# Data Set
##########
# The data set is sourced from Kaggle, licensed under Massachusetts Institute of
# Technology. It contains 10 variables (columns) along with 1001 entries (rows) 
# before filtering.The variables include User ID, Age,  Gender, Platform, Daily
# Usage Time (in minutes), Posts Per Day, Likes Received Per Day, Comments 
# Received Per Day, Messages Sent Per Day, and Dominant Emotion. The variables 
# included both numerical and categorical. 

setwd('C:/Users/17147/Desktop/Computer Science/CS 17 - Data Analysis in R/Project')
library(dplyr)
library(ggplot2)
library(tidyverse)

social <- read.csv('train.csv')
View(social)

# Ensure the columns are numeric
social$Age <- as.numeric(as.character(social$Age)) 
social$Daily_Usage_Time..minutes. <- as.numeric(as.character(social$Daily_Usage_Time..minutes.))

# Removing any NAs
social <- social |> filter(!is.na(Age))

#########
# Results
#########


######################################################
# Which platform was the most common for each emotion?

platform_emotion <- social |>
  group_by(Dominant_Emotion) |>
  summarize(Most_Common_Platform = Platform[which.max((table(Platform)))])

print(platform_emotion)

# Results: 
# The results for most dominant associated with each platform seem to align with 
# the general consensus. Twitter is typically a very political charged platform, 
# LinkedIn is used for job-hunting, and Facebook is typically used as a functional 
# platform for messaging, purchasing items, etc. The most interesting results 
# come from Instagram, which were associated with a variety of emotions# including 
# Anxiety, Happiness, and Sadness.

######################################################
# Ranking the platforms with the most time spent on it

colnames(social)

time_spent_platform <- social |>
  group_by(Platform) |>
  summarise(Total_Time_Spent = sum(`Daily_Usage_Time..minutes.`, na.rm = TRUE)) |>
  arrange(desc(Total_Time_Spent))

print(time_spent_platform)

ggplot(time_spent_platform, aes(x=reorder(Platform,-Total_Time_Spent), y=Total_Time_Spent, fill=Platform)) +
  geom_bar(stat="identity") + 
  labs(title="Total Time Spent on Each Platform", 
       x="Platform",
       y="Total Time Spent (minutes)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5), legend.position = "none")

# Results:
# Instagram had by far the most time spent on it with 36,220 minutes. More than
# double the second most Platform (Twitter). In terms of understanding the results,
# it makes sense that Telegram, Whatsapp, and Snapchat have the least amount of 
# time spent since they are primarily used for communication. Instagram, Twitter,
# and Facebook to some extent (The top 3) are also used for entertainment purposes.

######################################################
# Ranking the platforms with the most time spent on it

# Filter out rows with NA values in Daily Usage Time
social <- social |> filter(!is.na(Daily_Usage_Time..minutes.))

# Calculate the average daily usage time for each platform
average_time_spent_platform <- social |>
  group_by(Platform) |>
  summarise(Average_Daily_Usage_Time = mean(Daily_Usage_Time..minutes., na.rm = TRUE)) |>
  arrange(desc(Average_Daily_Usage_Time))

# Print the result
print(average_time_spent_platform)

# Create a bar plot for the average daily usage time for each platform
ggplot(average_time_spent_platform, aes(x=reorder(Platform, -Average_Daily_Usage_Time),
                                        y=Average_Daily_Usage_Time, 
                                        fill=Platform)) +
  geom_bar(stat="identity") + 
  labs(title="Average Daily Usage Time for Each Platform", 
       x="Platform",
       y="Average Daily Usage Time (minutes)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5), legend.position = "none")

# Results
# Similar to most time spent on each platform, the average daily usage time
# for each platform yielded Instagram as the highest. What was interesting was
# that the rest of the results did not match up with the most time spent on
# each platform. The rest of the platforms were in a similar ballpark of ~75-90
# minutes of average daily usage with the notable exception of LinkedIn which was
# closer to an average of 50 minutes per day.


######################################
# Most common platform for each gender

# Pie Chart of Each Platform per Gender:
filtered_social <- social |> filter(!(Gender %in% c('Marie', '27')))

unique_genders <- unique(filtered_social$Gender)

for (gender in unique_genders) 
{
  gender_data <- filtered_social |> filter(Gender == gender)
  platform_counts <- table(gender_data$Platform)
  
  pie(platform_counts,
      main=paste("Platform Distribution for", gender))
}

# Results:
# Categorizing the distribution of platform use by gender, the most dominant 
# platform for Females was Instagram, for Males it was Twitter, and for 
# Non-binary it was Facebook. Visually it looks like the Male distribution was
# the most spread out, and the least was Non-binary. 

#############################################################################
# Analyzing the relationship between Daily Usage Time and Age for each gender

analysis <- function(gender_data, gender){
  # Correlation coefficient
  correlation <- cor(gender_data$Age, 
                     gender_data$Daily_Usage_Time..minutes., use = "complete.obs")
  
  # linear regression
  lm_model <- lm(Daily_Usage_Time..minutes. ~ Age, data=gender_data)
  lm_summary <- summary(lm_model)
  
  cat("Gender: ", gender, "\n")
  print(lm_summary)
  
  # Scatter plot with regression line:
  p <- ggplot(gender_data, aes(x=Age, y=Daily_Usage_Time..minutes.)) +
    geom_point() +
    geom_smooth(method="lm", se=TRUE, color="red") + 
    labs(title=paste('Daily Usage Time vs Age for ', gender),
         x='Age',
         y='Daily Usage Time (Minutes)') +
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5))
  
  print(p)
}

# Perform analysis for each gender:
for (gender in unique_genders)
{
  gender_data <- social |> filter(Gender == gender)
  analysis(gender_data, gender)
}

# Results:
# Female equation: Time_Spent = 0.0027*Age + 105.9
#                  P-value = 0.2328
#                  R-squared = 0.0006347
# Male equation: Time_Spent = -1.5144*Age + 138.0
#                  P-value = 0.0123
#                  R-squared = 0.01886
# Non-Binary equation: Time_Spent = 3.1627*Age - 7.13
#                  P-value = 0.2.29e-10
#                  R-squared = 0.151

# For females, the P-value > 0.05 indicating that it is not statistically 
# significant. For males, there is some statistical significance since the 
# P-value is less than 0.05. This means there is a slight decrease in daily usage
# of social media with age. For Non-Binary individuals the P-value was 2.29e-10,
# indicating a high statistical significance between social media usage and age
# with the R value indicating that it explains 15.1% of the variance. 
# In conclusion, for females, age is not a contributing factor for usage of
# social media. For men, there's a slight decrease with age and for Non-binary,
# there is a significant increase in social media usage among older individuals.

############
# Conclusion
############
# In conclusion, this study showcased some of the emotions, time spent, and 
# revealed some trends associated with Age and time spent among different social
# media platforms. Instagram was the most commonly used social media with the
# most positive and negative emotions associated with it. Age was a contributing
# factor to time spent using social media for Non-binary individuals, and to some
# extent males as well. In terms of future studies, it would be interesting to 
# look at a wider range of emotions among individuals and to include other social
# media apps such as TikTok, MeetUp, and dating apps. In terms of what I've learned,
# this project made me realize the difficulties in gathering data. Kaggle made it
# easier, but sourcing through government websites is difficult and it is hard
# to find detailed data sets. This made me realize that much of the major battles
# in data analysis is compiling the data together properly and filtering. 

