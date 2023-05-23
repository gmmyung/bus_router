import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class BusStop {
  final LatLng location;
  final List<String> names;
  const BusStop(this.location, this.names);
}

class BusNode {
  final BusStop busStop;
  final TimeOfDay time;
  const BusNode(this.busStop, this.time);
}

class BusRoute {
  final List<BusNode> busNodes;
  final BusKind busKind;
  const BusRoute(this.busNodes, this.busKind);
}

class BusKind {
  final String lineName;
  final Color color;
  const BusKind(this.lineName, this.color);
}

const humphreysBusKind = [
  BusKind("Blue", Colors.blue),
  BusKind("Green", Colors.green),
  BusKind("Black", Colors.black),
  BusKind("Orange", Colors.orange),
  BusKind("Purple", Colors.purple),
];
