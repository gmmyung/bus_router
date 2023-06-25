import 'dart:io';
import 'package:bus_router/bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';

void main() {
  test('BusStop', () {
    const busStop = BusStop(LatLng(0, 0), "test");
    expect(busStop, isNotNull);
    expect(busStop.location, const LatLng(0, 0));
    expect(busStop.name, "test");
  });
  test('BusNode', () {
    const busNode = BusNode("test", Duration());
    expect(busNode, isNotNull);
    expect(busNode.busStop, "test");
    expect(busNode.arrivalTime, const Duration());
  });
  test('Schedule', () {
    const schedule = Schedule([1, 2, 3], [TimeOfDay(hour: 0, minute: 0)]);
    expect(schedule, isNotNull);
    expect(schedule.weekday, [1, 2, 3]);
    expect(schedule.time, [const TimeOfDay(hour: 0, minute: 0)]);
  });
  test('BusRoute', () {
    const busRoute = BusRoute(
      [BusNode("test", Duration(minutes: 1))],
      "test",
      Colors.black,
      [
        Schedule([1, 2, 3], [TimeOfDay(hour: 0, minute: 0)])
      ],
    );
    expect(busRoute, isNotNull);
    expect(busRoute.busNodes, [const BusNode("test", Duration(minutes: 1))]);
    expect(busRoute.lineName, "test");
    expect(busRoute.color, Colors.black);
    expect(busRoute.schedule, [
      const Schedule([1, 2, 3], [TimeOfDay(hour: 0, minute: 0)])
    ]);
  });
  test('BusStop.fromJson', () {
    final busStop = BusStop.fromJson({
      "location": {"latitude": 0.0, "longitude": 0.0},
      "name": "test"
    });
    expect(busStop, isNotNull);
    expect(busStop.location, const LatLng(0.0, 0.0));
    expect(busStop.name, "test");
  });
  test('BusNode.fromJson', () {
    final busNode = BusNode.fromJson({"busStop": "test", "arrivalTime": 1});
    expect(busNode, isNotNull);
    expect(busNode.busStop, "test");
    expect(busNode.arrivalTime, const Duration(minutes: 1));
  });
  test('Schedule.fromJson', () {
    final schedule = Schedule.fromJson({
      "weekday": [1, 2, 3],
      "time": [
        {"hour": 0, "minute": 0}
      ]
    });
    expect(schedule, isNotNull);
    expect(schedule.weekday, [1, 2, 3]);
    expect(schedule.time, [const TimeOfDay(hour: 0, minute: 0)]);
  });
  test('BusRoute.fromJson', () {
    final busRoute = BusRoute.fromJson({
      "busNodes": [
        {"busStop": "test", "arrivalTime": 1}
      ],
      "lineName": "test",
      "color": {"a": 255, "r": 0, "g": 0, "b": 0},
      "schedule": [
        {
          "weekday": [1, 2, 3],
          "time": [
            {"hour": 0, "minute": 0}
          ]
        }
      ]
    });
    expect(busRoute, isNotNull);
    expect(busRoute.busNodes[0].arrivalTime, const Duration(minutes: 1));
    expect(busRoute.busNodes[0].busStop, "test");
    expect(busRoute.lineName, "test");
    expect(busRoute.color, Colors.black);
    expect(busRoute.schedule[0].weekday, [1, 2, 3]);
    expect(busRoute.schedule[0].time, [const TimeOfDay(hour: 0, minute: 0)]);
  });
  test('loadBusInfo', () async {
    final string = File("assets/bus_info.json").readAsStringSync();
    final busInfo = await loadBusInfo(string);
    expect(busInfo, isNotNull);
    expect(busInfo.busRoutes, isNotEmpty);
    expect(busInfo.busStops, isNotEmpty);
  });
}
