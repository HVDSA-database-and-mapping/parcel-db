-- schema for hvdsa parcel database

CREATE SCHEMA hvdsa;

CREATE TABLE IF NOT EXISTS hvdsa.parcel (
    acreage_of_parent numeric,
    assessed_value numeric,
    building_assessment numeric,
    capped_value numeric,
    cvt_code varchar(10),
    cvt_description varchar(40),
    historical_district varchar(1),
    homestead_taxable numeric,
    homestea_pct numeric,
    lastupdate numeric,
    legal_description text,
    objectid int,
    owner_care_of varchar(100),
    owner_city varchar(100),
    owner_country varchar(100),
    owner_name varchar(100),
    owner_name2 varchar(100),
    owner_state varchar(2),
    owner_street varchar(100),
    owner_zip varchar(20),
    parent_parcel_num varchar(40),
    pin varchar(40),
    prop_city varchar(100),
    prop_class varchar(10),
    prop_class_description varchar(100),
    prop_state varchar(2),
    prop_street varchar(100),
    prop_street_num numeric, -- convert to int
    prop_zip varchar(20),
    school_district varchar(100),
    school_name varchar(100),
    sev numeric,
    shape_area numeric,
    shape_len numeric,
    statedarea varchar(20),
    status_code varchar(1),
    status_desc varchar(20),
    taxable_value numeric,
    tax_year numeric, -- convert to int
    txpyrs_care_of varchar(100),
    txpyrs_city varchar(100),
    txpyrs_country varchar(100),
    txpyrs_name varchar(100),
    txpyrs_state varchar(100),
    txpyrs_street_addr varchar(100),
    txpyrs_zip_code varchar(20),
    unit_apt_num varchar(20),
--    geometry text,
--   latlngcoords text,
    latlngcentroid text
--    numcoords int
);