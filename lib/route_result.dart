import 'package:bus_router/bus.dart';
import 'package:bus_router/router.dart';
import 'package:flutter/material.dart';
import 'package:bus_router/location_selection.dart';
import 'package:latlong2/latlong.dart';

class RouteResult extends StatefulWidget {
  const RouteResult({super.key, required this.dest, required this.busInfo});
  final LocationSelection dest;
  final BusInfo busInfo;
  @override
  State<RouteResult> createState() => _RouteResultState();
}

class _RouteResultState extends State<RouteResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
          children: widget.busInfo.busRoutes.map((route) {
        SingleBusRoute? singleRoute = SingleBusRoute.fromLocation(
            currentTime: DateTime(2023, 7,3,15,03),
            busRoute: route,
            endLocation: widget.dest.getLocation(),
            startLocation: const LatLng(36.9681715, 127.0081031));
        return ListTile(
          title: Text(singleRoute!.startBusStop),
          trailing: const SizedBox(
            height: 100,
          ),
        );
      }).toList()),
    );
  }
}
