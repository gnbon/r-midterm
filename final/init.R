# set loacale for macos
Sys.setlocale("LC_ALL", "en_US.UTF-8")
options(encoding = 'UTF-8')
Sys.setenv(LANG = "en_US.UTF-8")
localeToCharset()
par(family='Apple SD Gothic Neo')

# install needed packages
install.packages("dplyr")
install.packages("ggplot2")
install.packages("caret")

# import library
library(dplyr)
library(ggplot2)
library(gapminder)

library(caret)
library(survival)

# set work directory
setwd("~/workspace/R")
