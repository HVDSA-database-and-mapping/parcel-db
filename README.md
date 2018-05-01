# Database Restoration

If you want to create a new instance of the database or need to restore it, the easiest way is to use [pg_restore](https://www.postgresql.org/docs/9.6/static/app-pgrestore.html). A dump of the PostgreSQL database is kept on the HVDSA Database and Mapping Project Google Drive. Set up a PostgreSQL database server with the PostGIS extensions installed, and run ```pg_restore -C -d postgres hvdsa_db.bkp``` to recreate the full database.

# Database Creation Notes

1. Set up a PostgreSQL database server on DigitalOcean. They have an [excellent tutorial](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-16-04#create-a-new-role).

2. Install the PostGIS extensions for spatial data. A straightforward tutorial can be found [here](http://www.gis-blog.com/how-to-install-postgis-2-3-on-ubuntu-16-04-lts/).

2. Clean up the parcel data from Drive with [a shell script](csv_concatenate.sh).

2. Generate SQL from census tract, county, and congressional district shapefiles with [a shell script](govt_entity_shp2pgsql). Run the SQL results with psql.

2. Create the schema and load the data using the command from [this repo](all_counties_parcel_data.sql).

2. Convert the ArcGIS rings into PostGIS geometries with [the Python script](arcgis_to_wkt.py). This takes a while.

2. Add the longitude and latitude of centroids to the parcel table with [some PostGIS SQL](lonlat_centroid.sql).

2. Assign census tracts and congressional districts to the parcel table with [some more PostGIS SQL](tract_district_assignment.sql). This takes a few minutes.
