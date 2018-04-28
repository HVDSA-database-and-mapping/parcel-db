#!/bin/bash

# county and congressional district shapefiles downloaded from:
# https://www.census.gov/geo/maps-data/data/tiger-cart-boundary.html
# census tract shapefiles from HVDSA Drive

unzip cb_2017_us_county_500k.zip
unzip cb_2017_us_cd115_500k.zip
unzip Census_Tracts_HVDSA_Counties_shapefile.zip

shp2pgsql -s 4269 cb_2017_us_cd115_500k.shp hvdsa.congressional_district > congressional_district.sql

shp2pgsql -s 4269 cb_2017_us_county_500k.shp hvdsa.county > county.sql

shp2pgsql -s 4326 Census_Tracts_HVDSA_Counties.shp hvdsa.census_tract > census_tract.sql