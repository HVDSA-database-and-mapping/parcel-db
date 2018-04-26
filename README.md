# Database Creation Notes

1. Set up a PostgreSQL database server on DigitalOcean. They have an [excellent tutorial](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-16-04#create-a-new-role).

2. Create the schema using the command from [this repo](parcel_data.sql).

2. Import from the csv file to the database with:
```sql
COPY hvdsa.parcel FROM 'file.csv' WITH CSV HEADER;
```
