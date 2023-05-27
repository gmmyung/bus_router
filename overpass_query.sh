#!/bin/sh
rm assets/overpass_nodes.json
rm assets/overpass_building.json
curl https://overpass-api.de/api/interpreter -d "@assets/overpass_nodes_query.txt" > assets/overpass_nodes.json
curl https://overpass-api.de/api/interpreter -d "@assets/overpass_building_query.txt" > assets/overpass_building.json
```