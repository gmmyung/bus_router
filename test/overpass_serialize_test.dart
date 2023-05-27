import 'dart:io';
import 'package:bus_router/bus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';

void main() {
  test('loadOverPassBuilding', () async {
    final string = File("assets/bus_info.json").readAsStringSync();
    final busInfo = await loadBusInfo(string);
    expect(busInfo, isNotNull);
    expect(busInfo.busRoutes, isNotEmpty);
    expect(busInfo.busStops, isNotEmpty);
  });
}
