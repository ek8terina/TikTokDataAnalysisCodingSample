# TikTokDataCodingSample
Data collection, cleaning, and analysis for Senior Thesis Ver. 1

This repository represents all the underlying code of my senior thesis: "User-attempted Algorithm Control on TikTok- Disability Awareness and Blackout Day" version 1. Data collection was scraped in Python through the use of TikTokApi package by David Teather (code can be found on GitHub) slightly modified in order to ensure compatibility of mac OS Big Sur while the majority of cleaning and analysis was done in R. Both pdf versions of exclusively data figures/visualizations as well as the version 1 thesis for convenient comparison.

data_preparation.py represents selection of data attributes to be collected from any given TikTok
data_collection.py scrapes selected TikTok attributes 
Data_Cleaning.R takes raw data and writes cleaned data adding day variables among others
Data_Analysis.Rmd conducts DiD analysis between selected communities, checks trends to ensure decent comparability, and constructs a few additional tables for simple data visualization
