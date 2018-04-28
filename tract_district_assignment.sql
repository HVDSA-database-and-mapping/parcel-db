ALTER TABLE parcel ADD COLUMN cd_gid int;

UPDATE parcel p SET cd_gid = gid FROM congressional_district c
    WHERE ST_Contains(c.geom, ST_Transform(ST_Centroid(p.parcel_boundary), 4269))
    AND p.cd_gid is null;

ALTER TABLE parcel ADD COLUMN ct_gid int;

UPDATE parcel p SET ct_gid = gid FROM census_tract c
    WHERE ST_Contains(c.geom, ST_Transform(ST_Centroid(p.parcel_boundary), 4326))
    AND p.ct_gid is null;
