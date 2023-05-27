// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overpass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Building _$BuildingFromJson(Map<String, dynamic> json) => Building(
      json['id'] as int,
      (json['nodes'] as List<dynamic>).map((e) => e as int).toList(),
      json['tags'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$BuildingToJson(Building instance) => <String, dynamic>{
      'id': instance.id,
      'nodes': instance.nodes,
      'tags': instance.tags,
    };

BuildingQuery _$BuildingQueryFromJson(Map<String, dynamic> json) =>
    BuildingQuery(
      (json['version'] as num).toDouble(),
      json['generator'] as String,
      Osm3s.fromJson(json['osm3s'] as Map<String, dynamic>),
      (json['elements'] as List<dynamic>)
          .map((e) => Building.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BuildingQueryToJson(BuildingQuery instance) =>
    <String, dynamic>{
      'version': instance.version,
      'generator': instance.generator,
      'osm3s': instance.osm3s,
      'elements': instance.elements,
    };

Osm3s _$Osm3sFromJson(Map<String, dynamic> json) => Osm3s(
      json['timestamp_osm_base'] as String,
      json['copyright'] as String,
    );

Map<String, dynamic> _$Osm3sToJson(Osm3s instance) => <String, dynamic>{
      'timestamp_osm_base': instance.timestamp_osm_base,
      'copyright': instance.copyright,
    };

NodeQuery _$NodeQueryFromJson(Map<String, dynamic> json) => NodeQuery(
      (json['version'] as num).toDouble(),
      json['generator'] as String,
      Osm3s.fromJson(json['osm3s'] as Map<String, dynamic>),
      (json['elements'] as List<dynamic>)
          .map((e) => const NodeConverter().fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NodeQueryToJson(NodeQuery instance) => <String, dynamic>{
      'version': instance.version,
      'generator': instance.generator,
      'osm3s': instance.osm3s,
      'elements': instance.elements.map(const NodeConverter().toJson).toList(),
    };
