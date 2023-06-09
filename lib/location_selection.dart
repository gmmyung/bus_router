import 'package:bus_router/bus.dart';
import 'package:bus_router/map.dart';
import 'package:bus_router/overpass.dart';
import 'package:bus_router/route_result.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class LocationSelection {
  LatLng getLocation() {
    return const LatLng(0, 0);
  }

  String getName() {
    return "";
  }
}

class BuildingSelection extends LocationSelection {
  final Building building;
  final Map<int, LatLng> nodeMap;
  BuildingSelection({required this.building, required this.nodeMap});

  @override
  LatLng getLocation() {
    return building.getCenter(nodeMap);
  }

  @override
  String getName() {
    if (building.tags.name != null) {
      return building.tags.name!;
    } else if (building.tags.houseNumber != null) {
      return building.tags.houseNumber!;
    } else {
      return getLocation().toString();
    }
  }
}

class BusStopSelection extends LocationSelection {
  final BusStop busStop;
  BusStopSelection({required this.busStop});

  @override
  LatLng getLocation() {
    return busStop.location;
  }

  @override
  String getName() {
    return busStop.name;
  }
}

class LatLngSelection extends LocationSelection {
  final LatLng location;
  final String name;
  LatLngSelection({required this.location, required this.name});

  @override
  LatLng getLocation() {
    return location;
  }

  @override
  String getName() {
    return name;
  }
}

class LocationPicker extends StatefulWidget {
  final LocationSelection locationSelection;
  final BusInfo busInfo;
  const LocationPicker({super.key, required this.locationSelection ,required this.busInfo});

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Location"),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: SelectionMap(locationSelection: widget.locationSelection)),
          SizedBox(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RouteResult(dest: widget.locationSelection, busInfo: widget.busInfo,),),);
                    },
                    style: FilledButton.styleFrom(
                        minimumSize: const Size(350, 50)),
                    child: const Text("Select")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
