#**d3 Mekong Map**#

###[Click here for the demo](http://ianscrivener.github.io/d3-mekong-map/ "")

This is a d3 map of 5 Lower Mekong countries. Heavily adapted from the great work of Mike Bostock, the developer of **d3.js** [https://github.com/mbostock](https://github.com/mbostock "").

To reuse it with other countries simple grab the raw country & place data and extract/transform the spatial data for the countries you require.

<hr/>



##Get the spatial data


	mkdir downloads
	cd downloads
	
	wget http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/ne_10m_admin_0_map_subunits.zip
	wget http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/ne_10m_populated_places.zip

	unzip ne_10m_populated_places.zip 
	unzip ne_10m_admin_0_map_subunits.zip

	cd ../

##You need the GDAL application installed to use ogr2ogr

	apt-get install -y gdal-bin

##Load the topojson node.js module

of course you need to have node.js & npm installed already

	# then get to node.js package topojson
	npm install -g topojson



##Convert the shape file of the boundaries to a geojson

Use the 3 character country code (ISO 3166-1 Alpha-3) code for the countries you require - see [http://en.wikipedia.org/wiki/ISO_3166-1#Current_codes](http://en.wikipedia.org/wiki/ISO_3166-1#Current_codes "")

    ogr2ogr \
    	-f GeoJSON \
    	-where "ADM0_A3 IN ('THA', 'VNM', 'MMR','KHM','LAO')" \
    	subunits.json \
    	./downloads/ne_10m_admin_0_map_subunits.shp

##Convert the shape file of places to a geojson
Using the two character codes 

    ogr2ogr \
    	-f GeoJSON \
    	-where "ISO_A2 IN ('TH', 'VN', 'MM','KH','LA') AND SCALERANK < 5" \
    	places.json \
    	./downloads/ne_10m_populated_places.shp

##Merge the 2 geojson files and transform to topojson
 
    topojson \
    	--id-property SU_A3 \
    	-p name=NAME \
    	-p name \
    	-o mekong.json \
    	subunits.json \
    	places.json
    	
##For lazy people
The **spatial-convert.sh** shell script includes the following steps. Tweak the countries and 'SCALERANK' of the places as required.
