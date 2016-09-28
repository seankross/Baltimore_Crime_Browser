# Downloaded from https://data.baltimorecity.gov/Public-Safety/BPD-Part-1-Victim-Based-Crime-Data/wsfq-mvij
# 2016-09-27 20:18:20 EDT
# File downloaded as crime.csv

library(dplyr)
library(lubridate)
library(readr)
library(magrittr)
library(stringr)

crime <- read_csv("crime.csv")

colnames(crime)[which(colnames(crime) == "Inside/Outside")] <- "Inside_Outside"

crime %<>%
  mutate(CrimeDate = mdy(CrimeDate)) %>%
  mutate(CrimeTime = hms(CrimeTime)) %>%
  mutate(Inside_Outside = recode(Inside_Outside, "I" = "Inside", 
                                 "O" = "Outside")) %>%
  mutate(Lat = str_extract_all(`Location 1`, "-?[0-9]{2}\\.[0-9]+")[[1]][1]) %>%
  mutate(Lng = str_extract_all(`Location 1`, "-?[0-9]{2}\\.[0-9]+")[[1]][2]) %>%
  select(-Post, -`Location 1`, -`Total Incidents`)

saveRDS(crime, "crime.rds")
