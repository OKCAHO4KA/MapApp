import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

import 'package:maps_app/markers/markers.dart';

Future<BitmapDescriptor> getStartCustomMarker(
    int duration, String destino) async {
  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);
  const size = ui.Size(350, 150);
  final startMarker =
      StartMarkerPainter(minutes: duration, destination: destino);

  startMarker.paint(canvas, size);

  final picture = recorder.endRecording();

  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteDate = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteDate!.buffer.asUint8List());
}

Future<BitmapDescriptor> getEndCustomMarker(int kms, String destino) async {
  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);
  const size = ui.Size(350, 150);
  final endMarker = EndMarkerPainter(kms: kms, destination: destino);

  endMarker.paint(canvas, size);

  final picture = recorder.endRecording();

  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteDate = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteDate!.buffer.asUint8List());
}
