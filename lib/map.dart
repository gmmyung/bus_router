import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MainMap extends StatefulWidget {
  const MainMap({
    super.key,
    this.onTap,
    required this.mapController,
  });

  final MapController mapController;
  final Function(TapPosition, LatLng)? onTap;

  @override
  State<MainMap> createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: widget.mapController,
      options: MapOptions(
        onTap: widget.onTap,
        maxZoom: 18,
        maxBounds: LatLngBounds(
          LatLng(36.9918227, 126.9685131),
          LatLng(36.9431782, 127.0538392),
        ),
        center: LatLng(36.9675, 127.041111),
        zoom: 17.0,
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://api.mapbox.com/styles/v1/gmmyung/clhxgciqh003g01o72nfg8ltr/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZ21teXVuZyIsImEiOiJjbGh4ZzBjcm8wb3ZhM2VvMTgwaGpvdHN2In0.sKV8TaW8a_i3hGiec17OBw',
          additionalOptions: const {
            'accessToken':
                'pk.eyJ1IjoiZ21teXVuZyIsImEiOiJjbGh4ZzVsaXUwdHEwM29xYTRvc2xxd3U4In0.wyB5UE7IN8mpr5my5cZnxg',
            'id': 'mapbox.mapbox-streets-v8',
          },
        ),
      ],
    );
  }
}
