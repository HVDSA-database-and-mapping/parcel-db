CREATE SCHEMA hvdsa;

CREATE TABLE IF NOT EXISTS hvdsa.parcel_jackson (
    objectid int,
    pin varchar(100),
    liberpage varchar(100),
    o_city varchar(100),
    owner varchar(100),
    owner2 varchar(100),
    o_state varchar(2),
    o_address varchar(100),
    o_zip varchar(10),
    p_city varchar(100),
    p_fulladd varchar(100),
    p_state varchar(2),
    p_zip varchar(10),
    p_status varchar(10),
    p_acreage numeric,
    p_assmbor1 numeric,
    p_assmbor2 numeric,
    p_assmbor3 numeric,
    p_assmbor4 numeric,
    p_hpercent numeric,
    p_taxmbor1 numeric,
    govunit varchar(100),
    schooldist varchar(100),
    spe_length varchar(4),
    shortpin varchar(100),
    p_taxmbor2 numeric,
    p_taxmbor3 numeric,
    p_taxmbor4 numeric,
    tax_unit varchar(100),
    shape varchar(10), -- all say 'POLYGON'
    updated varchar(100),
    p_class varchar(100),
    legal_desc text,
    shape_length numeric,
    shape_area numeric,
    mls varchar(1), -- null
    class varchar(1), -- null
    type varchar(1), -- null
    area varchar(1), -- null
    price varchar(1), -- null
    address varchar(1), -- null
    geometry text
);

CREATE TABLE IF NOT EXISTS hvdsa.parcel_livingston (
    objectid int,
    long_pid varchar(100),
    short_pid varchar(100),
    gis_acres numeric,
    in_date bigint,
    split_from varchar(100),
    comb_from varchar(100),
    edit_type smallint,
    source smallint,
    edit_req smallint,
    desc_close smallint,
    edit_date bigint,
    edit_tech varchar(4),
    comments text,
    facilityid varchar(100),
    o_name1 varchar(100),
    o_name2 varchar(100),
    o_careof varchar(100),
    o_street varchar(100),
    o_city varchar(100),
    o_state varchar(2),
    o_zip varchar(10),
    p_addr_f varchar(100),
    p_addr varchar(100),
    p_prefix varchar(4),
    p_road varchar(100),
    p_city varchar(100),
    p_state varchar(2),
    p_zip varchar(10),
    class varchar(10),
    class_desc varchar(100),
    sch_dist varchar(100),
    sd_desc varchar(100),
    zoning varchar(100),
    pre_pct numeric,
    pre_val numeric,
    assess_val numeric,
    taxabl_val numeric,
    eq_val numeric,
    tent_val numeric,
    liberpage varchar(1),
    legal text,
    shapestarea numeric,
    shapestlength numeric,
    geometry text
);

CREATE TABLE IF NOT EXISTS hvdsa.parcel_washtenaw (
    acreage_of_parent numeric,
    assessed_value numeric,
    building_assessment numeric,
    capped_value numeric,
    cvt_code varchar(10),
    cvt_description varchar(40),
    historical_district varchar(4),
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
    status_code varchar(4),
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
    geometry text
);

COPY hvdsa.parcel_jackson FROM '/home/rwturner/hvdsa-data/raw/jackson.csv' WITH CSV HEADER;
ALTER TABLE hvdsa.parcel_jackson ADD COLUMN id SERIAL PRIMARY KEY;
COPY hvdsa.parcel_livingston FROM '/home/rwturner/hvdsa-data/raw/livingston.csv' WITH CSV HEADER;
ALTER TABLE hvdsa.parcel_livingston ADD COLUMN id SERIAL PRIMARY KEY;
COPY hvdsa.parcel_washtenaw FROM '/home/rwturner/hvdsa-data/raw/washtenaw.csv' WITH CSV HEADER;
ALTER TABLE hvdsa.parcel_washtenaw ADD COLUMN id SERIAL PRIMARY KEY;

CREATE TABLE IF NOT EXISTS hvdsa.counties (
    name varchar(20) PRIMARY KEY
);
INSERT INTO hvdsa.counties (name) VALUES ('Jackson');
INSERT INTO hvdsa.counties (name) VALUES ('Livingston');
INSERT INTO hvdsa.counties (name) VALUES ('Washtenaw');

CREATE TABLE IF NOT EXISTS hvdsa.parcel (
    id SERIAL PRIMARY KEY,
    county varchar(20) REFERENCES hvdsa.counties,
    short_pin varchar(100),
    zoning varchar(100),
    pre_percent numeric,
    pre_value numeric,
    eq_value numeric,
    tent_value numeric,
    acreage_of_parent numeric,
    assessed_value numeric,
    building_assessment numeric,
    capped_value numeric,
    cvt_code varchar(10),
    cvt_description varchar(40),
    historical_district varchar(4),
    homestead_taxable numeric,
    homestead_percent numeric,
    lastupdate numeric,
    legal_description text,
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
    stated_area varchar(20),
    status_code varchar(4),
    status_desc varchar(20),
    taxable_value numeric,
    txpyrs_care_of varchar(100),
    txpyrs_city varchar(100),
    txpyrs_country varchar(100),
    txpyrs_name varchar(100),
    txpyrs_state varchar(100),
    txpyrs_street_addr varchar(100),
    txpyrs_zip_code varchar(20),
    unit_apt_num varchar(20),
    geometry text,
    parcel_boundary geometry(MULTIPOLYGON, 3857)
);

INSERT INTO hvdsa.parcel
(county, short_pin, acreage_of_parent, assessed_value, homestead_percent, legal_description,
owner_city, owner_name, owner_name2, owner_state, owner_street, owner_zip, pin, prop_city, prop_class_description,
prop_state, prop_street, prop_zip, school_district, shape_area, shape_len, status_desc, taxable_value,
geometry)
SELECT
'Jackson', shortpin, p_acreage, p_assmbor1, p_hpercent, legal_desc, o_city, owner, owner2, o_state,
o_address, o_zip, pin, p_city, p_class, p_state, p_fulladd, p_zip, schooldist, shape_area, shape_length,
p_status, p_taxmbor1, geometry
FROM hvdsa.parcel_jackson;

INSERT INTO hvdsa.parcel
(county, short_pin, zoning, pre_percent, pre_value, eq_value, tent_value, acreage_of_parent,
    assessed_value, legal_description, owner_care_of, owner_city,
    owner_name, owner_name2, owner_state, owner_street, owner_zip,
    pin, prop_city, prop_class, prop_class_description, prop_state, prop_street,
    prop_zip, school_district, school_name, shape_area, shape_len, taxable_value, geometry)
SELECT
'Livingston', short_pid, zoning, pre_pct, pre_val, eq_val, tent_val, gis_acres, assess_val, legal,
o_careof, o_city, o_name1, o_name2, o_state, o_street, o_zip, long_pid, p_city, class, class_desc,
p_state, p_road, p_zip, sch_dist, sd_desc, shapestarea, shapestlength, taxabl_val, geometry
FROM hvdsa.parcel_livingston;

INSERT INTO hvdsa.parcel
(county, acreage_of_parent,
    assessed_value, building_assessment, capped_value, cvt_code, cvt_description, historical_district,
    homestead_taxable, homestead_percent, legal_description, owner_care_of, owner_city,
    owner_country, owner_name, owner_name2, owner_state, owner_street, owner_zip, parent_parcel_num,
    pin, prop_city, prop_class, prop_class_description, prop_state, prop_street, prop_street_num,
    prop_zip, school_district, school_name, sev, shape_area, shape_len, stated_area, status_code,
    status_desc, taxable_value, txpyrs_care_of, txpyrs_city, txpyrs_country, txpyrs_name,
    txpyrs_state, txpyrs_street_addr, txpyrs_zip_code, unit_apt_num, geometry)
SELECT
'Washtenaw', acreage_of_parent, assessed_value, building_assessment, capped_value, cvt_code, cvt_description,
historical_district, homestead_taxable, homestea_pct, legal_description,
owner_care_of, owner_city, owner_country, owner_name, owner_name2, owner_state, owner_street,
owner_zip, parent_parcel_num, pin, prop_city, prop_class, prop_class_description, prop_state,
prop_street, prop_street_num, prop_zip, school_district, school_name, sev, shape_area, shape_len,
statedarea, status_code, status_desc, taxable_value, txpyrs_care_of, txpyrs_city,
txpyrs_country, txpyrs_name, txpyrs_state, txpyrs_street_addr, txpyrs_zip_code, unit_apt_num,
geometry
FROM hvdsa.parcel_washtenaw;


