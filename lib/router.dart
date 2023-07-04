import 'package:latlong2/latlong.dart';
import 'bus.dart';

const double walkingSpeed = 5.0; // km/h

class SingleBusRoute {
  final BusRoute busLine;
  final String startBusStop;
  final String endBusStop;
  final Duration totalDuration;
  final Duration walkingTimeToStartStop;
  final Duration walkingTimeToEndStop;
  final DateTime busStopArrivalTime;
  final DateTime busDepartureTime;
  final DateTime busArrivalTime;
  final DateTime arrivalTime;


  SingleBusRoute(
      this.busLine,
      this.startBusStop,
      this.endBusStop,
      this.totalDuration,
      this.walkingTimeToStartStop,
      this.walkingTimeToEndStop,
      this.busStopArrivalTime,
      this.busDepartureTime,
      this.busArrivalTime,
      this.arrivalTime);

  static SingleBusRoute? fromLocation({required BusRoute busRoute, required LatLng startLocation,
      required LatLng endLocation, required DateTime currentTime}) {
    for (final schedule in busRoute.schedule) {
      if (schedule.weekday.contains(intToWeekday(currentTime.weekday))) {
        final (startStop, distanceToStartStop) =
            busRoute.findNearestBusStop(startLocation);
        final (endStop, distanceToEndStop) =
            busRoute.findNearestBusStop(endLocation);
        final walkingTimeToStartStop = getWalkingTime(distanceToStartStop);
        final walkingTimeToEndStop = getWalkingTime(distanceToEndStop);
        final busStopArrivalTime = currentTime.add(walkingTimeToStartStop);
        final busDepartureTime =
            busRoute.getDepartureTime(busStopArrivalTime, startStop);
	if (busDepartureTime == null) {
	  return null;
	}
        final busArrivalTime =
            busDepartureTime.add(busRoute.getDuration(startStop, endStop)!);
        final arrivalTime = busArrivalTime.add(walkingTimeToEndStop);
        return SingleBusRoute(
	    busRoute,
	    startStop,
	    endStop,
	    arrivalTime.difference(currentTime),
	    walkingTimeToStartStop,
	    walkingTimeToEndStop,
	    busStopArrivalTime,
	    busDepartureTime,
	    busArrivalTime,
	    arrivalTime);
      }
    }
    return null;
  }
}

Duration getWalkingTime(double distance) {
  return Duration(
      seconds: (distance / walkingSpeed * Duration.secondsPerHour).round());
}
