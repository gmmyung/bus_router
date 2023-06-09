// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusStop _$BusStopFromJson(Map<String, dynamic> json) => BusStop(
      const LatLngConverter()
          .fromJson(json['location'] as Map<String, dynamic>),
      json['name'] as String,
      json['altName'] as String?,
      $enumDecodeNullable(_$DirectionEnumMap, json['direction']),
    );

Map<String, dynamic> _$BusStopToJson(BusStop instance) => <String, dynamic>{
      'location': const LatLngConverter().toJson(instance.location),
      'name': instance.name,
      'altName': instance.altName,
      'direction': _$DirectionEnumMap[instance.direction],
    };

const _$DirectionEnumMap = {
  Direction.forward: 'forward',
  Direction.reverse: 'reverse',
};

BusNode _$BusNodeFromJson(Map<String, dynamic> json) => BusNode(
      json['name'] as String,
      const DurationConverter().fromJson(json['arrivalTime'] as int),
      $enumDecodeNullable(_$DirectionEnumMap, json['direction']),
      (json['path'] as List<dynamic>?)
          ?.map((e) =>
              const LatLngConverter().fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BusNodeToJson(BusNode instance) => <String, dynamic>{
      'name': instance.name,
      'direction': _$DirectionEnumMap[instance.direction],
      'arrivalTime': const DurationConverter().toJson(instance.arrivalTime),
      'path': instance.path?.map(const LatLngConverter().toJson).toList(),
    };

Schedule _$ScheduleFromJson(Map<String, dynamic> json) => Schedule(
      (json['weekday'] as List<dynamic>)
          .map((e) => $enumDecode(_$WeekdayEnumMap, e))
          .toList(),
      (json['time'] as List<dynamic>)
          .map((e) =>
              const TimeOfDayConverter().fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'weekday': instance.weekday.map((e) => _$WeekdayEnumMap[e]!).toList(),
      'time': instance.time.map(const TimeOfDayConverter().toJson).toList(),
    };

const _$WeekdayEnumMap = {
  Weekday.mon: 'mon',
  Weekday.tue: 'tue',
  Weekday.wed: 'wed',
  Weekday.thu: 'thu',
  Weekday.fri: 'fri',
  Weekday.sat: 'sat',
  Weekday.sun: 'sun',
};

BusRoute _$BusRouteFromJson(Map<String, dynamic> json) => BusRoute(
      (json['busNodes'] as List<dynamic>)
          .map((e) => BusNode.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['lineName'] as String,
      const ColorConverter().fromJson(json['color'] as Map<String, dynamic>),
      (json['schedule'] as List<dynamic>)
          .map((e) => Schedule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BusRouteToJson(BusRoute instance) => <String, dynamic>{
      'busNodes': instance.busNodes,
      'schedule': instance.schedule,
      'lineName': instance.lineName,
      'color': const ColorConverter().toJson(instance.color),
    };

BusInfo _$BusInfoFromJson(Map<String, dynamic> json) => BusInfo(
      (json['busRoutes'] as List<dynamic>)
          .map((e) => BusRoute.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['busStops'] as List<dynamic>)
          .map((e) => BusStop.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BusInfoToJson(BusInfo instance) => <String, dynamic>{
      'busRoutes': instance.busRoutes,
      'busStops': instance.busStops,
    };
