part of 'search_bloc.dart';

class SearchState extends Equatable {
  final bool displayManualMarker;
  final List<Feature> places;
  final List<Feature> historyPlaces;

  const SearchState(
      {this.historyPlaces = const [],
      this.places = const [],
      this.displayManualMarker = false});

  SearchState copyWith(
          {bool? displayManualMarker,
          final List<Feature>? places,
          final List<Feature>? historyPlaces}) =>
      SearchState(
          displayManualMarker: displayManualMarker ?? this.displayManualMarker,
          places: places ?? this.places,
          historyPlaces: historyPlaces ?? this.historyPlaces);

  @override
  List<Object> get props => [displayManualMarker, places, historyPlaces];
}
