rm *.json

ogr2ogr \
-f GeoJSON \
-where "ADM0_A3 IN ('THA', 'VNM', 'MMR','KHM','LAO')" \
subunits.json \
./downloads/ne_10m_admin_0_map_subunits.shp

ogr2ogr \
-f GeoJSON \
-where "ISO_A2 IN ('TH', 'VN', 'MM','KH','LA') AND SCALERANK < 6" \
places.json \
./downloads/ne_10m_populated_places.shp

topojson \
--id-property SU_A3 \
-p name=NAME \
-p name \
-o mekong.json \
subunits.json \
places.json
