import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:maps_app/services/services.dart';

import '../../models/models.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  TrafficService trafficService;
  SearchBloc({required this.trafficService}) : super(const SearchState()) {
    on<OnActivateManualMarkerEvent>((event, emit) {
      emit(state.copyWith(displayManualMarker: true));
    });

    on<OffActivateManualMarkerEvent>((event, emit) {
      emit(state.copyWith(displayManualMarker: false));
    });

    on<OnNewPlacesFoundEvent>(
      (event, emit) {
        emit(state.copyWith(places: event.places));
      },
    );

    on<AddToHistoryEvent>(
      (event, emit) {
        emit(state
            .copyWith(historyPlaces: [event.place, ...state.historyPlaces]));
      },
    );
  }

  Future<RouteDestination> getCoorsStartToEnd(LatLng start, LatLng end) async {
    final trafficResponse = await trafficService.getCoorsStartToEnd(start, end);

    final endPlace = await trafficService.getInformacionByCoors(end);
    final distance = trafficResponse.routes[0].distance;

    final duration = trafficResponse.routes[0].duration;
    final geometry = trafficResponse.routes[0].geometry;
//decodificar geometry

    final polyline = decodePolyline(geometry, accuracyExponent: 6);
    final points = polyline
        .map((coords) => LatLng(coords[0].toDouble(), coords[1].toDouble()))
        .toList();
    return RouteDestination(
        endInfoPlace: endPlace,
        points: points,
        duration: duration,
        distance: distance);
  }

  Future getPlacesByQuery(LatLng proximity, String query) async {
    final respNewPlaces =
        await trafficService.getResultByQuery(proximity, query);

    add(OnNewPlacesFoundEvent(respNewPlaces));
  }
}
