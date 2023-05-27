import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import "package:json_annotation/json_annotation.dart";

part 'bus.g.dart';

@JsonSerializable()
class BusStop {
  @LatLngConverter()
  final LatLng location;
  final String name;
  const BusStop(this.location, this.name);
  factory BusStop.fromJson(Map<String, dynamic> json) =>
      _$BusStopFromJson(json);
  Map<String, dynamic> toJson() => _$BusStopToJson(this);
}

class LatLngConverter implements JsonConverter<LatLng, Map<String, dynamic>> {
  const LatLngConverter();

  @override
  LatLng fromJson(Map<String, dynamic> json) {
    return LatLng(json["latitude"]!, json["longitude"]!);
  }

  @override
  Map<String, dynamic> toJson(LatLng object) {
    return {"latitude": object.latitude, "longitude": object.longitude};
  }
}

@JsonSerializable()
class BusNode {
  final String busStop;
  @DurationConverter()
  final Duration arrivalTime;
  const BusNode(this.busStop, this.arrivalTime);
  factory BusNode.fromJson(Map<String, dynamic> json) =>
      _$BusNodeFromJson(json);
  Map<String, dynamic> toJson() => _$BusNodeToJson(this);
}

class DurationConverter implements JsonConverter<Duration, int> {
  const DurationConverter();

  @override
  Duration fromJson(int json) {
    return Duration(minutes: json);
  }

  @override
  int toJson(Duration object) {
    return object.inMinutes;
  }
}

@JsonSerializable()
class Schedule {
  final List<int> weekday;

  @TimeOfDayConverter()
  final List<TimeOfDay> time;

  const Schedule(this.weekday, this.time);
  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}

class TimeOfDayConverter
    implements JsonConverter<TimeOfDay, Map<String, dynamic>> {
  const TimeOfDayConverter();

  @override
  TimeOfDay fromJson(Map<String, dynamic> json) {
    return TimeOfDay(hour: json["hour"]!, minute: json["minute"]!);
  }

  @override
  Map<String, dynamic> toJson(TimeOfDay object) {
    return {"hour": object.hour, "minute": object.minute};
  }
}

@JsonSerializable()
class BusRoute {
  final List<BusNode> busNodes;
  final List<Schedule> schedule;
  final String lineName;
  @ColorConverter()
  final Color color;
  const BusRoute(this.busNodes, this.lineName, this.color, this.schedule);
  factory BusRoute.fromJson(Map<String, dynamic> json) =>
      _$BusRouteFromJson(json);
  Map<String, dynamic> toJson() => _$BusRouteToJson(this);
}

class ColorConverter implements JsonConverter<Color, Map<String, dynamic>> {
  const ColorConverter();

  @override
  Color fromJson(Map<String, dynamic> json) {
    return Color.fromARGB(json["a"]!, json["r"]!, json["g"]!, json["b"]!);
  }

  @override
  Map<String, dynamic> toJson(Color object) {
    return {
      "a": object.alpha,
      "r": object.red,
      "g": object.green,
      "b": object.blue
    };
  }
}

@JsonSerializable()
class BusInfo {
  final List<BusRoute> busRoutes;
  final List<BusStop> busStops;
  const BusInfo(this.busRoutes, this.busStops);
  factory BusInfo.fromJson(Map<String, dynamic> json) =>
      _$BusInfoFromJson(json);
  Map<String, dynamic> toJson() => _$BusInfoToJson(this);
}

// Load local file to BusInfo
Future<BusInfo> loadBusInfo(String string) async {
  print("Load bus info");
  return BusInfo.fromJson(jsonDecode(string));
}
