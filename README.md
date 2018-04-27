# Database Creation Notes

1. Set up a PostgreSQL database server on DigitalOcean. They have an [excellent tutorial](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-16-04#create-a-new-role).

2. Install the PostGIS extensions for spatial data. A straightforward tutorial can be found [here](http://www.gis-blog.com/how-to-install-postgis-2-3-on-ubuntu-16-04-lts/).

2. Clean up the data from Drive with [this shell script](csv_concatenate.sh).

2. Create the schema and load the data using the command from [this repo](all_counties_parcel_data.sql).
