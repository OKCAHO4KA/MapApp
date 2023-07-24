import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/models/models.dart';

class RouteDestination {
  final List<LatLng> points;
  final double duration;
  final double distance;
  final Feature endInfoPlace;

  RouteDestination(
      {required this.endInfoPlace,
      required this.points,
      required this.duration,
      required this.distance});
}
