ALTER TABLE parcel ADD COLUMN lon_centroid numeric;
ALTER TABLE parcel ADD COLUMN lat_centroid numeric;

-- SRID 4326 is the WGS84 lon/lat coordinate system
UPDATE parcel SET lon_centroid=ST_X(ST_Transform(ST_Centroid(parcel_boundary), 4326))
    WHERE parcel_boundary is not null;
UPDATE parcel SET lat_centroid=ST_Y(ST_Transform(ST_Centroid(parcel_boundary), 4326))
    WHERE parcel_boundary is not null;