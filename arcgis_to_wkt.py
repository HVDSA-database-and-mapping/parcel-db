
# coding: utf-8

# # PostGIS Geometry Conversion
# 
# This notebook takes the ArcGIS-formatted geometries from the scraped parcel data and converts it to the WKT format used in PostGIS.
# 
# Special care is taken to convert the Washtenaw county data into the Web Mercator SRID.

# In[1]:


import psycopg2
import json
import pyproj


# In[2]:


db_credentials = {
    'database': 'hvdsa',
    'user': 'hvdsa',
    'password': 'hvdsa',
    'host': '159.89.87.236',
    'port': 5432
}


# In[42]:


def arcgispt_to_wktpt(pt):
    return '%s %s' % (pt[0], pt[1])


def arcgisring_to_wktring(ring):
    wktpts = map(arcgispt_to_wktpt, ring)
    return '((' + ','.join(wktpts) + '))'


def arcgis_to_postgis(geometry, county):
    geom_json = json.loads(geometry.replace("'", '"'))
    rings = geom_json['rings']
    wkt_rings = map(arcgisring_to_wktring, rings)
    rings_str = ','.join(wkt_rings)
    result = 'MULTIPOLYGON(' + rings_str + ')'
    return result    

# Fails for Washtenaw county for unclear reasons. WKID problem?

proj_standard = pyproj.Proj(init="epsg:3857")
proj_washtenaw = pyproj.Proj(init="epsg:2253")

def arcgispt_to_latlon(pt, county):
    x, y = pt
    if county == 'Washtenaw':
        raise Value
    else:
        lon, lat = proj_standard(x, y, inverse=True)
    return lat, lon


def arcgisring_to_latlonring(ring, county):
    return [arcgispt_to_latlon(p, county) for p in ring]


def arcgis_to_latlon(geometry, county):
    geom_json = json.loads(geometry.replace("'", '"'))
    rings = geom_json['rings']
    rings_latlon = [arcgisring_to_latlonring(ring, county) for ring in rings]
    return rings
# In[43]:


# Livingston and Jackson are in the target SRID (3857)

conn = None
try:
    conn = psycopg2.connect(**db_credentials)
    conn.autocommit = True
    cur = conn.cursor()
    
    cur_read = conn.cursor()
    cur_write = conn.cursor()
    cur_read.execute("SELECT id, county, geometry FROM hvdsa.parcel WHERE parcel_boundary is null AND county IN ('Livingston', 'Jackson')")
    for id, county, geometry in cur_read:
        bdy = arcgis_to_postgis(geometry, county)
        try:
            cur_write.execute(
                'UPDATE hvdsa.parcel SET parcel_boundary=ST_GeomFromText(%s, 3857) WHERE id=%s',
                (bdy, id)
            )
            conn.commit()
        except:
            continue
    
except psycopg2.DatabaseError as error:
    raise error
except psycopg2.OperationalError:
    print('Database is not accessible.')
finally:
    if conn is not None:
        conn.close()


# In[44]:


# Washtenaw needs to be converted from SRID 2253 to 3857

conn = None
try:
    conn = psycopg2.connect(**db_credentials)
    conn.autocommit = True
    cur = conn.cursor()
    
    cur_read = conn.cursor()
    cur_write = conn.cursor()
    cur_read.execute("SELECT id, county, geometry FROM hvdsa.parcel WHERE parcel_boundary is null AND county = 'Washtenaw'")
    for id, county, geometry in cur_read:
        bdy = arcgis_to_postgis(geometry, 'Jackson')
        try:
            cur_write.execute(
                'UPDATE hvdsa.parcel SET parcel_boundary=ST_Transform(ST_GeomFromText(%s, 2253), 3857) WHERE id=%s',
                (bdy, id)
            )
            conn.commit()
        except Exception as e:
            raise e
    
except psycopg2.DatabaseError as error:
    raise error
except psycopg2.OperationalError:
    print('Database is not accessible.')
finally:
    if conn is not None:
        conn.close()

