import 'dart:io';
import 'package:bus_router/overpass.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('loadOverPassBuilding', () async {
    final string = File("assets/overpass_building.json").readAsStringSync();
    final busInfo = await loadOverPassBuilding(string);
    expect(busInfo, isNotNull);
    expect(busInfo.elements, isNotEmpty);
  });

  test('loadOverPassNode', () async {
    final string = File("assets/overpass_nodes.json").readAsStringSync();
    final busInfo = await loadOverPassNode(string);
    expect(busInfo, isNotNull);
    expect(busInfo.elements, isNotEmpty);
  });
}
