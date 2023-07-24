import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class SearchResult {
  final bool cancel;
  final bool? manual;
  final LatLng? position;
  final String? namePlace;
  final String? descriptionPlace;

  SearchResult(
      {this.namePlace,
      this.descriptionPlace,
      this.position,
      required this.cancel,
      this.manual = false});

  @override
  String toString() {
    return '{cancel $cancel, manual $manual}';
  }
}
