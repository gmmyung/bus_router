import "dart:convert";

import "package:json_annotation/json_annotation.dart";
import "package:latlong2/latlong.dart";

part 'overpass.g.dart';

@JsonSerializable()
class Building {
  final int id;
  final List<int> nodes;
  final Map<String, dynamic> tags;
  const Building(this.id, this.nodes, this.tags);
  factory Building.fromJson(Map<String, dynamic> json) =>
      _$BuildingFromJson(json);
  Map<String, dynamic> toJson() => _$BuildingToJson(this);
}

@JsonSerializable()
class BuildingQuery {
  final double version;
  final String generator;
  final Osm3s osm3s;
  final List<Building> elements;
  const BuildingQuery(this.version, this.generator, this.osm3s, this.elements);
  factory BuildingQuery.fromJson(Map<String, dynamic> json) =>
      _$BuildingQueryFromJson(json);
  Map<String, dynamic> toJson() => _$BuildingQueryToJson(this);
}

@JsonSerializable()
class Osm3s {
  final String timestamp_osm_base;
  final String copyright;
  const Osm3s(this.timestamp_osm_base, this.copyright);
  factory Osm3s.fromJson(Map<String, dynamic> json) => _$Osm3sFromJson(json);
  Map<String, dynamic> toJson() => _$Osm3sToJson(this);
}

@NodeConverter()
class Node {
  final int id;
  final LatLng location;
  const Node(this.id, this.location);
}

class NodeConverter implements JsonConverter<Node, Map<String, dynamic>> {
  const NodeConverter();

  @override
  Node fromJson(Map<String, dynamic> json) {
    return Node(json["id"]!, LatLng(json["lat"]!, json["lon"]!));
  }

  @override
  Map<String, dynamic> toJson(Node object) {
    return {
      "id": object.id,
      "lat": object.location.latitude,
      "lon": object.location.longitude
    };
  }
}

@JsonSerializable()
class NodeQuery {
  final double version;
  final String generator;
  final Osm3s osm3s;
  @NodeConverter()
  final List<Node> elements;
  const NodeQuery(this.version, this.generator, this.osm3s, this.elements);
  factory NodeQuery.fromJson(Map<String, dynamic> json) =>
      _$NodeQueryFromJson(json);
  Map<String, dynamic> toJson() => _$NodeQueryToJson(this);
}

Future<BuildingQuery> loadOverPassBuilding(String json) async {
  return BuildingQuery.fromJson(await jsonDecode(json));
}

Future<NodeQuery> loadOverPassNode(String json) async {
  return NodeQuery.fromJson(await jsonDecode(json));
}
