// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overpass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Building _$BuildingFromJson(Map<String, dynamic> json) => Building(
      json['id'] as int,
      (json['nodes'] as List<dynamic>).map((e) => e as int).toList(),
      Tags.fromJson(json['tags'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BuildingToJson(Building instance) => <String, dynamic>{
      'id': instance.id,
      'nodes': instance.nodes,
      'tags': instance.tags,
    };

Tags _$TagsFromJson(Map<String, dynamic> json) => Tags(
      json['building'] as String?,
      json['addr:housenumber'] as String?,
      json['name'] as String?,
      json['name:ko'] as String?,
      json['addr:street'] as String?,
      json['amenity'] as String?,
      json['alt_name'] as String?,
      json['short_name'] as String?,
      json['official_name'] as String?,
    );

Map<String, dynamic> _$TagsToJson(Tags instance) => <String, dynamic>{
      'building': instance.buildingType,
      'addr:housenumber': instance.houseNumber,
      'name': instance.name,
      'name:ko': instance.nameKo,
      'addr:street': instance.street,
      'amenity': instance.amenity,
      'alt_name': instance.altName,
      'short_name': instance.shortName,
      'official_name': instance.officialName,
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
      'timestamp_osm_base': instance.timestampOsmBase,
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
