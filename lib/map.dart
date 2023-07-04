import 'package:bus_router/bus.dart';
import 'package:bus_router/location_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

const accessToken =
    'pk.eyJ1IjoiZ21teXVuZyIsImEiOiJjbGh4ZzVsaXUwdHEwM29xYTRvc2xxd3U4In0.wyB5UE7IN8mpr5my5cZnxg';
const urlTemplate =
    'https://api.mapbox.com/styles/v1/gmmyung/clhxgciqh003g01o72nfg8ltr/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZ21teXVuZyIsImEiOiJjbGh4ZzBjcm8wb3ZhM2VvMTgwaGpvdHN2In0.sKV8TaW8a_i3hGiec17OBw';
const mapId = 'mapbox.mapbox-streets-v8';

TileLayer myMap = TileLayer(
  urlTemplate: urlTemplate,
  additionalOptions: const {
    'accessToken': accessToken,
    'id': mapId,
  },
);

class SelectionMap extends StatefulWidget {
  final LocationSelection? locationSelection;
  const SelectionMap({super.key, this.locationSelection});

  @override
  State<SelectionMap> createState() => _SelectionMapState();
}

class _SelectionMapState extends State<SelectionMap> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            maxZoom: 18,
            maxBounds: LatLngBounds(
              const LatLng(36.9918227, 126.9685131),
              const LatLng(36.9431782, 127.0538392),
            ),
            center: widget.locationSelection != null
                ? widget.locationSelection!.getLocation()
                : const LatLng(36.9675, 127.041111),
            zoom: 17.0,
          ),
          children: [
            myMap,
          ],
        ),
        const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.location_pin,
                color: Colors.red,
                size: 40,
              ),
              SizedBox(height: 40, width: 40),
            ],
          ),
        ),
      ],
    );
  }
}

class MainMap extends StatefulWidget {
  const MainMap({
    super.key,
    required this.mapController,
    this.path,
    this.color,
    this.busStops,
  });

  final List<LatLng>? path;
  final Color? color;
  final List<BusStop>? busStops;
  final MapController mapController;

  @override
  State<MainMap> createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: widget.mapController,
      options: MapOptions(
        maxZoom: 18,
        maxBounds: LatLngBounds(
          const LatLng(36.9918227, 126.9685131),
          const LatLng(36.9431782, 127.0538392),
        ),
        center: const LatLng(36.9675, 127.041111),
        zoom: 15.0,
      ),
      children: [
        myMap,
        if (widget.path != null) ...[
          PolylineLayer(
            polylines: [
              Polyline(
                points: widget.path!,
                // color gets darker
                gradientColors: [
                  widget.color!,
                  widget.color!.withOpacity(0.5),
                  widget.color!,
                  widget.color!.withOpacity(0.5),
                  widget.color!
                ],
                colorsStop: [0.0, 0.25, 0.5, 0.75, 1.0],
                //color: widget.color!,
                strokeWidth: 10.0,
              )
            ],
          )
        ],
        if (widget.busStops != null) ...[
          MarkerLayer(rotate: true, markers: [
            for (var busStop in widget.busStops!)
              Marker(
                point: busStop.location,
                width: 120,
                height: 150,
                builder: (context) {
                  return InkWell(
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const SizedBox(height: 40),
                              Text(
                                busStop.name,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                          // bottomLeft
                                          offset: Offset(-1.5, -1.5),
                                          color: Colors.white),
                                      Shadow(
                                          // bottomRight
                                          offset: Offset(1.5, -1.5),
                                          color: Colors.white),
                                      Shadow(
                                          // topRight
                                          offset: Offset(1.5, 1.5),
                                          color: Colors.white),
                                      Shadow(
                                          // topLeft
                                          offset: Offset(-1.5, 1.5),
                                          color: Colors.white),
                                    ]),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: widget.color!, width: 4),
                          ),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                    onTap: () {
                      print(busStop.name);
                    },
                  );
                },
              )
          ])
        ],
      ],
    );
  }
}
