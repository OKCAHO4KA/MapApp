import 'dart:convert';

class PlacesResponse {
  final String type;
  final List<Feature> features;
  final String attribution;

  PlacesResponse({
    required this.type,
    required this.features,
    required this.attribution,
  });

  factory PlacesResponse.fromRawJson(String str) =>
      PlacesResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlacesResponse.fromJson(Map<String, dynamic> json) => PlacesResponse(
        type: json["type"],
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
        attribution: json["attribution"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "attribution": attribution,
      };
}

class Feature {
  final String id;
  final String type;
  final List<String> placeType;
  final Properties properties;
  final String textEs;
  final String placeNameEs;
  final String text;
  final String placeName;
  final List<double> center;
  final Geometry geometry;
  final List<Context>? context;
  final String? language;
  final String? matchingText;
  final String? matchingPlaceName;

  Feature({
    required this.id,
    required this.type,
    required this.placeType,
    required this.properties,
    required this.textEs,
    required this.placeNameEs,
    required this.text,
    required this.placeName,
    required this.center,
    required this.geometry,
    required this.context,
    required this.language,
    required this.matchingText,
    required this.matchingPlaceName,
  });

  factory Feature.fromRawJson(String str) => Feature.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        properties: Properties.fromJson(json["properties"]),
        textEs: json["text_es"],
        placeNameEs: json["place_name_es"],
        text: json["text"],
        placeName: json["place_name"],
        center: List<double>.from(json["center"].map((x) => x.toDouble())),
        geometry: Geometry.fromJson(json["geometry"]),
        context:
            List<Context>.from(json["context"].map((x) => Context.fromJson(x))),
        language: json["language"],
        matchingText: json["matching_text"],
        matchingPlaceName: json["matching_place_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType.map((x) => x)),
        "properties": properties.toJson(),
        "text_es": textEs,
        "place_name_es": placeNameEs,
        "text": text,
        "place_name": placeName,
        "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toJson(),
        "context": List<dynamic>.from(context!.map((x) => x.toJson())),
        "language": language,
        "matching_text": matchingText,
        "matching_place_name": matchingPlaceName,
      };
  @override
  String toString() {
    return 'Feature $text';
  }
}

class Context {
  final String id;
  final String mapboxId;
  final String textEs;
  final String text;
  final String? wikidata;
  final String? language;
  final String? shortCode;

  Context({
    required this.id,
    required this.mapboxId,
    required this.textEs,
    required this.text,
    required this.wikidata,
    required this.language,
    required this.shortCode,
  });

  factory Context.fromRawJson(String str) => Context.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Context.fromJson(Map<String, dynamic> json) => Context(
        id: json["id"],
        mapboxId: json["mapbox_id"],
        textEs: json["text_es"],
        text: json["text"],
        wikidata: json["wikidata"],
        language: json["language"],
        shortCode: json["short_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mapbox_id": mapboxId,
        "text_es": textEs,
        "text": text,
        "wikidata": wikidata,
        "language": language,
        "short_code": shortCode,
      };
}

class Geometry {
  final List<double> coordinates;
  final String type;

  Geometry({
    required this.coordinates,
    required this.type,
  });

  factory Geometry.fromRawJson(String str) =>
      Geometry.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "type": type,
      };
}

class Properties {
  final String? foursquare;
  final bool? landmark;
  final String? address;
  final String? category;
  final String? maki;
  final String? wikidata;
  final String? mapboxId;

  Properties({
    required this.foursquare,
    required this.landmark,
    required this.address,
    required this.category,
    required this.maki,
    required this.wikidata,
    required this.mapboxId,
  });

  factory Properties.fromRawJson(String str) =>
      Properties.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        foursquare: json["foursquare"],
        landmark: json["landmark"],
        address: json["address"],
        category: json["category"],
        maki: json["maki"],
        wikidata: json["wikidata"],
        mapboxId: json["mapbox_id"],
      );

  Map<String, dynamic> toJson() => {
        "foursquare": foursquare,
        "landmark": landmark,
        "address": address,
        "category": category,
        "maki": maki,
        "wikidata": wikidata,
        "mapbox_id": mapboxId,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
