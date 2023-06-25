import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import "package:json_annotation/json_annotation.dart";
import 'datetime_extend.dart';

part 'bus.g.dart';


enum Direction {
  @JsonValue("forward")
  forward,
  @JsonValue("reverse")
  reverse,
}

@JsonSerializable()
class BusStop {
  @LatLngConverter()
  final LatLng location;
  final String name;
  final String? altName;
  final Direction? direction;
  const BusStop(this.location, this.name, this.altName, this.direction);
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
  final String name;
  final Direction? direction;
  @DurationConverter()
  final Duration arrivalTime;
  // First element of path SHOULD be the location of bus stop
  @LatLngConverter()
  final List<LatLng>? path;
  const BusNode(this.name, this.arrivalTime, this.direction, this.path);
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

enum Weekday{
  @JsonValue("mon")
  mon,
  @JsonValue("tue")
  tue,
  @JsonValue("wed")
  wed,
  @JsonValue("thu")
  thu,
  @JsonValue("fri")
  fri,
  @JsonValue("sat")
  sat,
  @JsonValue("sun")
  sun,
}

@JsonSerializable()
class Schedule {
  final List<Weekday> weekday;

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

  List<LatLng> getPath() {
    final List<LatLng> path = [];
    for (final busNode in busNodes) {
      if (busNode.path != null) {
	path.addAll(busNode.path!);
      }
    }
    return path;
  }

  // return nearest bus stop from location
  (String, double) findNearestBusStop(LatLng location) {
    const Distance distance = Distance();
    double minDistance = double.infinity;
    String? nearestBusStop;
    for (final busNode in busNodes) {
      final double currentDistance =
	  distance.as(LengthUnit.Kilometer, location, busNode.path!.first);
      if (currentDistance < minDistance) {
	minDistance = currentDistance;
	nearestBusStop = busNode.name;
      }
    }
    return (nearestBusStop!, minDistance);
  }
  
  
  DateTime? getDepartureTime(DateTime now, String busStop) {
    final int weekday = now.weekday;
    final TimeOfDay nowTime = TimeOfDay.fromDateTime(now);
    for (final schedule in this.schedule) {
      if (schedule.weekday.contains(weekday)) {
        for (final laneStartTime in schedule.time) {
	  final startingBusNode = busNodes.firstWhere((element) => element.name == busStop);
	  if (laneStartTime + startingBusNode.arrivalTime > nowTime) {
	    return DateTime(now.year, now.month, now.day, laneStartTime.hour, laneStartTime.minute);
	  }
	}
      }
    }
    return null;
  }

  Duration? getDuration(String startBusStop, String endBusStop) {
    final int startIndex = busNodes.indexWhere((element) => element.name == startBusStop);
    final int endIndex = busNodes.indexWhere((element) => element.name == endBusStop);
    if (startIndex == -1 || endIndex == -1) {
      return null;
    }
    final Duration duration = busNodes[endIndex].arrivalTime - busNodes[startIndex].arrivalTime;
    return duration;
  }
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

// Fetch bus stop from list of bus stops
BusStop? fetchBusStop(
    List<BusStop> busStops, String name, Direction? direction) {
  for (final busStop in busStops) {
    if (busStop.name == name && busStop.direction == direction) {
      return busStop;
    }
  }
  return null;
}
