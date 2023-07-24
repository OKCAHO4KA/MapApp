import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/helpers/helpers.dart';
import 'package:maps_app/models/models.dart';

import '../../theme/map_hopper.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;
  GoogleMapController? _mapController;
  LatLng? mapCenter;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<OnMapInitializedEvent>(_onInitMap);

    locationBloc.stream.listen((event) {
      if (event.lastKnowLocation != null) {
        add(UpdateUserPolylineEvent(event.myLocationHistory));
      }

      if (!state.isFollowUser) return;
      if (event.lastKnowLocation == null) return;

      moveCamera(event.lastKnowLocation!);
    });

    on<OnStopFollowingUserEvent>(
        (event, emit) => emit(state.copyWith(isFollowUser: false)));

    on<OnStartFollowingUserEvent>(_onStartFollowingUser);

    on<UpdateUserPolylineEvent>(_onPolylineNewPoint);

    on<OnToggleUserRoute>(
        (event, emit) => emit(state.copyWith(showMyRoute: !state.showMyRoute)));

    //   on<DisplayPolylineEvent>(
    //       (emit, event) => emit(state.copyWith(polylines: event   )));

    on<DisplayPolylineEvent>((event, emit) => emit(
        state.copyWith(polylines: event.polylines, markers: event.markers)));
  }

  Future drawRoutePolyline(RouteDestination destination) async {
    final myRoute = Polyline(
        polylineId: const PolylineId('route'),
        color: const Color.fromRGBO(236, 158, 76, 1),
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: destination.points);

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['route'] = myRoute;

    final int kmDistanciaRuta =
        (destination.distance / 1000).floorToDouble().toInt();
    final int durationRoute =
        (destination.duration / 60).floorToDouble().toInt();

    // final startMarkerPng = await getAssetImageMarker();
    // final endMarkerNetworkImage = await getNetworkImageMarker();

    final startMarkerPng =
        await getStartCustomMarker(durationRoute, 'Mi ubicación');
    final endMarkerNetworkImage = await getEndCustomMarker(
        kmDistanciaRuta, destination.endInfoPlace.text);
    final startMarker = Marker(
        anchor: const Offset(0.06, 0.85),
        icon: startMarkerPng,
        // infoWindow: InfoWindow(
        //     title: 'Inicio',
        //     snippet:
        //         ' Distancia: $kmDistanciaRuta km, Duración: $durationRoute minutos'),
        markerId: const MarkerId('start'),
        position: destination.points.first // position: destination.points[0]
        );

    final endMarker = Marker(
        anchor: const Offset(0.9, 0.85),
        icon: endMarkerNetworkImage,
        // infoWindow: InfoWindow(
        //     title: destination.endInfoPlace.text,
        //     snippet: destination.endInfoPlace.placeNameEs),
        markerId: const MarkerId('end'),
        position: destination.points.last);

    final currentMarkers = Map<String, Marker>.from(state.markers);
    currentMarkers['start'] = startMarker;
    currentMarkers['end'] = endMarker;

    add(DisplayPolylineEvent(currentPolylines, currentMarkers));
  }

  void _onInitMap(OnMapInitializedEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;
    _mapController!.setMapStyle(jsonEncode(mapHopper));
    emit(state.copyWith(isMapInitialized: true));
  }

  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
  }

  void _onStartFollowingUser(
      OnStartFollowingUserEvent event, Emitter<MapState> emit) {
    emit(state.copyWith(isFollowUser: true));
    if (locationBloc.state.lastKnowLocation == null) return;
    moveCamera(locationBloc.state.lastKnowLocation!);
  }

  void _onPolylineNewPoint(
      UpdateUserPolylineEvent event, Emitter<MapState> emit) {
    final myRoute = Polyline(
        polylineId: const PolylineId('myRoute'),
        color: const Color.fromRGBO(236, 158, 76, 1),
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: event.userLocation);

    final currentPolylines = Map<String, Polyline>.from(state.polylines);

    currentPolylines['myRoute'] = myRoute;
    emit(state.copyWith(polylines: currentPolylines));
  }
}
