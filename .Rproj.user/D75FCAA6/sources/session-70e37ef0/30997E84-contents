library(shiny)
library(ggplot2)
library(dplyr)
library(tidyverse)
library(tidyr)
library(sf)
library(leaflet)

# Chargement des fichiers contenant les fonctions pour générer les charts
source("R/reseau.R")
source("R/covid.R")

emissions <- read.table("data/processed/emissions.csv", sep=",")
shapes_speeds <- st_read("data/processed/shapes_speeds.geojson") # Pour lire les fichiers geojson, on utilise la librairie sf
gares_communes <- st_read("data/processed/gares_communes.geojson")

