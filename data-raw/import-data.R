

# LOAD PACKAGES -----------------------------------------------------------

library(tidyverse)
library(tidycensus)
library(janitor)
library(readxl)
library(usethis)
library(devtools)
library(tigris)
library(sf)
library(opencage)
library(tidygeocoder)


# TFFF OFFICES ------------------------------------------------------------

tfff_offices <- tribble(
  ~city, ~state,
  "Roseburg", "Oregon",
  "Eugene", "Oregon"
) %>%
  mutate(address = str_glue("{city}, {state}")) %>%
  geocode(address = address,
          method = "osm") %>%
  select(-address)

use_data(tfff_offices,
         overwrite = TRUE)

# COUNTIES ----------------------------------------------------------------

oregon_siskiyou_counties_geospatial <- counties(state = c("OR", "CA")) %>%
  clean_names() %>%
  filter(statefp == 41 | name == "Siskiyou") %>%
  mutate(state = case_when(
    statefp == 41 ~ "Oregon",
    TRUE ~ "California"
  )) %>%
  select(geoid, name, state) %>%
  rename(county = name) %>%
  mutate(core_county = case_when(
    county %in% c("Douglas", "Coos", "Siskiyou") ~ "Core County",
    TRUE ~ "Not Core County"
  )) %>%
  mutate(urban_rural = case_when(
    county %in% c("Multnomah", "Washington", "Clackamas") ~ "Metro",
    county %in% c("Polk", "Linn", "Benton", "Deschutes", "Jackson", "Lane", "Marion") ~ "Rural-Urban Mix",
    county %in% c("Lake", "Harney", "Malheur", "Grant", "Wheeler", "Baker", "Wallowa", "Morrow", "Gilliam", "Sherman") ~ "Frontier",
    TRUE ~ "Rural"
  ))

use_data(oregon_siskiyou_counties_geospatial,
         overwrite = TRUE)



# FRONTIER AND REMOTE -----------------------------------------------------

# Data from here: https://www.ers.usda.gov/data-products/frontier-and-remote-area-codes/frontier-and-remote-area-codes/#2010%20Frontier%20and%20Remote%20Area%20Codes%20Data%20Files
# download.file("https://www.ers.usda.gov/webdocs/DataFiles/51020/FARcodesZIPdata2010WithAKandHI.xlsx?v=0",
#               destfile = "data-raw/far.xlsx")

oregon_california_far_zips <- read_excel("data-raw/far.xlsx",
                                         sheet = "FAR ZIP Code Data") %>%
  clean_names() %>%
  filter(state %in% c("CA", "OR")) %>%
  select(name, state, zip, far1:far4) %>%
  mutate(far_level = far1 + far2 + far3 + far4) %>%
  select(-(far1:far4)) %>%
  rename(community = name,
         zip_code = zip) %>%
  mutate(state = case_when(
    state == "OR" ~ "Oregon",
    state == "CA" ~ "California"
  ))

use_data(oregon_california_far_zips,
         overwrite = TRUE)

# COMMUNITIES -------------------------------------------------------------

# * Stuff Defined by TFFF ---------------------------------------------------

# * These come from a PDF TFFF made that Max emailed me on Feb 27 2020

oregon_communities_urban_rural <- c("Eugene",
                                    "Gresham",
                                    "Portland",
                                    "Salem",
                                    "Albany",
                                    "Beaverton",
                                    "Bend",
                                    "Corvallis",
                                    "Hillsboro",
                                    "Medford",
                                    "Springfield",
                                    "Aloha",
                                    "Keizer",
                                    "Lake Oswego",
                                    "Tigard",
                                    "Central Point",
                                    "Four Corners",
                                    "Milwaukie",
                                    "Oak Grove",
                                    "Oregon City",
                                    "Sherwood",
                                    "Troutdale",
                                    "Tualatin",
                                    "West Linn",
                                    "Wilsonville",
                                    "Bull Mountain",
                                    "Cedar Hills",
                                    "Cedar Mill",
                                    "Deschutes River Woods",
                                    "Fairview",
                                    "Garden Home-Whitford",
                                    "Gladstone",
                                    "Happy Valley",
                                    "Oak Hills",
                                    "Oatfield",
                                    "Raleigh Hills",
                                    "West Haven-Sylvan",
                                    "West Slope",
                                    "Metzger",
                                    "Phoenix",
                                    "Wood Village",
                                    "Durham",
                                    "Stafford",
                                    "Maywood Park") %>%
  tibble() %>%
  set_names("community") %>%
  mutate(urban_rural = "Urban")



# Get list of Siskiyou communities from spreadsheet that TFFF shared with me

siskiyou_communities <- read_excel("data-raw/tfff-communities.xlsx") %>%
  clean_names() %>%
  rename("county_name" = "cntynam",
         "county_region_name" = "cntyrgnnam",
         "name" = "city") %>%
  select(-c(cntyrgnnbr, geographic_region_nbr, vstcntynbr, tstamp)) %>%
  # Mt Shasta is duplicated so need to drop one
  filter(name != "Mt Shasta") %>%
  drop_na(name) %>%
  filter(state == "CA") %>%
  add_row(name = "Shingletown",
          state = "CA") %>%
  pull(name)


# * Get Communities from Census -------------------------------------------------------------

oregon_communities <- get_acs(geography = "place",
                              state = "OR",
                              variables = "B01003_001") %>%
  clean_names() %>%
  mutate(name = str_remove(name, c("California"))) %>%
  mutate(name = str_remove(name, c("Oregon"))) %>%
  mutate(name = str_remove(name, c("CDP"))) %>%
  mutate(name = str_remove(name, c("city"))) %>%
  mutate(name = str_remove(name, c(" ,"))) %>%
  mutate(name = str_remove(name, c("town,"))) %>%
  mutate(name = str_trim(name)) %>%
  mutate(state = "Oregon")

california_communities <- get_acs(geography = "place",
                                  state = "CA",
                                  # county = "Siskiyou",
                                  variables = "B01003_001") %>%
  clean_names() %>%
  mutate(name = str_remove(name, c("California"))) %>%
  mutate(name = str_remove(name, c("Oregon"))) %>%
  mutate(name = str_remove(name, c("CDP"))) %>%
  mutate(name = str_remove(name, c("city"))) %>%
  mutate(name = str_remove(name, c(" ,"))) %>%
  mutate(name = str_remove(name, c("town,"))) %>%
  mutate(name = str_trim(name)) %>%
  filter(name %in% siskiyou_communities) %>%
  mutate(state = "California")


# * Communities Geospatial --------------------------------------------------

oregon_california_communities_geospatial <- places(state = c("OR", "CA")) %>%
  clean_names() %>%
  filter(statefp == 41 | name %in% siskiyou_communities) %>%
  mutate(state = case_when(
    statefp == 41 ~ "Oregon",
    TRUE ~ "California"
  )) %>%
  select(geoid, name, state, intptlat, intptlon) %>%
  rename(community = name,
         lat = intptlat,
         lon = intptlon)

use_data(oregon_california_communities_geospatial,
         overwrite = TRUE)

oregon_california_communities_geospatial %>%
  filter(str_detect(community, "Maple"))

# * Merge + Save ------------------------------------------------------------

oregon_siskiyou_communities <- bind_rows(oregon_communities, california_communities) %>%
  select(geoid, name, state, estimate) %>%
  rename("population" = "estimate",
         "community" = "name") %>%
  left_join(oregon_communities_urban_rural,
            by = "community") %>%
  # Add urban/rural
  mutate(urban_rural = replace_na(urban_rural, "Rural"))
  # # Add FAR
  # left_join(oregon_california_far_zips,
  #           by = c("community", "state")) %>%
  # # Calculate the max FAR level for any community
  # # Have to do this because there are multiple zips for single communities
  # group_by(geoid) %>%
  # mutate(far_level = max(far_level)) %>%
  # ungroup() %>%
  # select(-zip_code) %>%
  # distinct(geoid, .keep_all = TRUE) %>%
  # # Add geospatial data
  # left_join(oregon_california_communities_geocoded,
  #           by = "geoid")


use_data(oregon_siskiyou_communities,
         overwrite = TRUE)


˜# FICB --------------------------------------------------------------------

ficb_field_coordinators <- read_excel("data-raw/ficb-map-data.xlsx",
                                 sheet = "Field Coordinators") %>%
  clean_names() %>%
  select(name, hometown_city, hometown_state, county, lat, lon) %>%
  filter(name != "Roque Barros") %>%
  filter(name != "Max Gimbel") %>%
  rename(city = hometown_city,
         state = hometown_state)

use_data(ficb_field_coordinators,
         overwrite = TRUE)
