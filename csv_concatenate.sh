# Script for combining the many csv files into one
#
# This script assumes that you have downloaded the
# three county geometry files from Drive and they
# are zipped together in a file called all_counties.zip

unzip all_counties.zip
mkdir raw

unzip -qq jackson_all_fields_w_geometry.zip
cd jackson_all_fields/
# Get the header from one of the files
head jackson_row_9.csv -n 1 >> jackson.txt
# Throw away the first line from each file and concatenate to output
tail -q -n +2 *.csv >> jackson.txt
rm *.csv
# filename chosen to indicate dos line endings
mv jackson.txt ../raw/jackson.csv.dos
cd ..
rm -rf jackson_all_fields
rm jackson_all_fields_w_geometry.zip

unzip -qq livingston_all_fields_w_geometry.zip
cd livingston_all_fields/
head livingston_row_9.csv -n 1 >> livingston.txt
tail -q -n +2 *.csv >> livingston.txt
rm *.csv
mv livingston.txt ../raw/livingston.csv.dos
cd ..
rm -rf livingston_all_fields
rm livingston_all_fields_w_geometry.zip

unzip -qq washtenaw_all_fields_w_geometry.zip
cd washtenaw_all_fields_w_geometry/
head washtenaw_row9.csv -n 1 >> washtenaw.txt
tail -q -n +2 *.csv >> washtenaw.txt
rm *.csv
mv washtenaw.txt ../raw/washtenaw.csv.dos
cd ..
rm -rf washtenaw_all_fields_w_geometry
rm washtenaw_all_fields_w_geometry.zip

rm -rf __MACOSX

cd raw

# remove dos line endings
cat jackson.csv.dos | tr -d '\r' > jackson.csv; rm jackson.csv.dos
cat livingston.csv.dos | tr -d '\r' > livingston.csv; rm livingston.csv.dos
cat washtenaw.csv.dos | tr -d '\r' > washtenaw.csv; rm washtenaw.csv.dos

# Remove lines with no results
sed -i '/N,o, ,r,e,s,u,l,t,s/d' washtenaw.csv > /dev/null
sed -i '/N,o, ,r,e,s,u,l,t,s/d' jackson.csv > /dev/null
sed -i '/N,o, ,r,e,s,u,l,t,s/d' livingston.csv > /dev/null

# Change 'Null' to empty string
sed -i 's/Null//g' jackson.csv
sed -i 's/Null//g' livingston.csv
sed -i 's/Null//g' washtenaw.csv

# make a template for building sql schemas
echo 'CREATE TABLE IF NOT EXISTS hvdsa.parcel_jackson (' > jackson.sql
# this gets the header, converts to lower case, strips special characters, adds 'text' sql type, and changes spaces to newlines
echo "`head jackson.csv -n 1` text" | tr '[:upper:]' '[:lower:]' | tr -d '#().' | sed -e $'s/,/ text,\\\n\\\t/g' >> jackson.sql
echo ');' >> jackson.sql
echo 'CREATE TABLE IF NOT EXISTS hvdsa.parcel_livingston (' > livingston.sql
echo "`head livingston.csv -n 1` text" | tr '[:upper:]' '[:lower:]' | tr -d '#().' | sed -e $'s/,/ text,\\\n\\\t/g' >> livingston.sql
echo ');' >> livingston.sql
echo 'CREATE TABLE IF NOT EXISTS hvdsa.parcel_washtenaw (' > washtenaw.sql
echo "`head washtenaw.csv -n 1` text" | tr '[:upper:]' '[:lower:]' | tr -d '#().' | sed -e $'s/,/ text,\\\n\\\t/g' >> washtenaw.sql
echo ');' >> washtenaw.sql
cat *.sql > parcels.sql
