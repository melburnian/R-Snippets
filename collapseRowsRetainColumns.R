# This snippet consolidates a dataset with multiple rows for each unique identifier, returning each unique identifier as single row without losing any column values.

# Remove existing data from the workspace
rm(list=ls())

# Set your working directory
setwd("/Users/xxxxx/Documents")

# Install packages
install.packages("dplyr","tidyr","readxl")

# Call libraries
library(dplyr)
library(readxl)
library(tidyr)

# Set df from example data
df <- read_excel('example.xlsx')

# Lessgoooooooo
# ID is the primary key or unique identifier that you want to use when summarising the data
# att1, att2, att3 are the columns you want to include in the summary. Change these to match those required from your dataset
df %>% 
  group_by(ID) %>%
  fill(att1, att2, att3, .direction = "updown") %>%
  distinct()
