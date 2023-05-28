import "dart:convert";

import "package:json_annotation/json_annotation.dart";
import "package:latlong2/latlong.dart";

part 'overpass.g.dart';

@JsonSerializable()
class Building {
  final int id;
  final List<int> nodes;
  final Tags tags;
  const Building(this.id, this.nodes, this.tags);
  factory Building.fromJson(Map<String, dynamic> json) =>
      _$BuildingFromJson(json);
  Map<String, dynamic> toJson() => _$BuildingToJson(this);
}

@JsonSerializable()
class Tags {
  @JsonKey(name: "building")
  final String? buildingType;
  @JsonKey(name: "addr:housenumber")
  final String? houseNumber;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "name:ko")
  final String? nameKo;
  @JsonKey(name: "addr:street")
  final String? street;
  @JsonKey(name: "amenity")
  final String? amenity;
  @JsonKey(name: "alt_name")
  final String? altName;
  @JsonKey(name: "short_name")
  final String? shortName;
  @JsonKey(name: "official_name")
  final String? officialName;
  const Tags(
    this.buildingType,
    this.houseNumber,
    this.name,
    this.nameKo,
    this.street,
    this.amenity,
    this.altName,
    this.shortName,
    this.officialName,
  );
  factory Tags.fromJson(Map<String, dynamic> json) => _$TagsFromJson(json);
  Map<String, dynamic> toJson() => _$TagsToJson(this);
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
  @JsonKey(name: "timestamp_osm_base")
  final String timestampOsmBase;
  final String copyright;
  const Osm3s(this.timestampOsmBase, this.copyright);
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
