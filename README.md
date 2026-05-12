# Social Media Usage Analysis

## Overview
This project analyzes patterns in social media usage using R, with a focus on emotional associations, platform engagement, and demographic trends. The analysis explores how different social media platforms relate to user emotions, average daily usage time, and age-based behavior across gender groups.

The project was completed as part of an introductory R data analysis course prior to beginning graduate studies at the University of Southern California.

---

## Objectives
The study focuses on four primary questions:

1. Which social media platform is most associated with each dominant emotion?
2. Which platforms have the highest total and average daily usage time?
3. Which platforms are most commonly used among different gender groups?
4. Is there a relationship between age and daily social media usage time across genders?

---

## Technologies Used
- **R**
- **R Markdown**
- **dplyr**
- **ggplot2**
- **tidyverse**

---

## Dataset
The dataset was sourced from Kaggle and contains:
- 1001 user entries
- Demographic information
- Social media platform usage
- Daily usage time
- Engagement metrics
- Dominant emotional states

Variables include:
- Age
- Gender
- Platform
- Daily Usage Time (minutes)
- Posts Per Day
- Likes Received Per Day
- Comments Received Per Day
- Messages Sent Per Day
- Dominant Emotion

---

## Key Findings

### Emotional Associations
- Twitter was most commonly associated with anger.
- LinkedIn was commonly associated with boredom.
- Instagram was associated with multiple emotional states including happiness, anxiety, and sadness.

### Platform Usage
- Instagram had the highest total and average daily usage time.
- Communication-focused platforms such as Telegram and WhatsApp showed lower overall usage times.

### Gender Trends
- Instagram was the dominant platform among female users.
- Twitter was most common among male users.
- Facebook was most common among non-binary users.

### Age vs Usage
Linear regression analysis showed:
- No statistically significant relationship between age and usage time for females.
- A slight negative relationship for males.
- A statistically significant positive relationship for non-binary users.

---

## Visualizations
The project includes:
- Bar charts for total platform usage
- Bar charts for average daily usage
- Pie charts for platform distribution by gender
- Scatter plots with regression lines for age vs usage analysis

---

## Files

| File | Description |
|---|---|
| `social-media-analysis.R` | Main R analysis script |
| `social-media-analysis.Rmd` | R Markdown report source |
| `social-media-analysis.pdf` | Final report |
| `social-media-analysis.html` | Rendered HTML report |
| `social-media-analysis_code.pdf` | Exported code walkthrough |
| `train.csv` | Dataset used for analysis |

---

## Future Improvements
Potential future extensions include:
- Expanding to additional platforms such as TikTok or Reddit
- Time-series analysis of usage behavior
- Sentiment analysis using text-based social media data
- More advanced predictive modeling techniques

---

## Author
Omar Nava  
Master’s Student in Applied Data Science  
University of Southern California