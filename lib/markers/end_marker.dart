import 'package:flutter/material.dart';

class EndMarkerPainter extends CustomPainter {
  final int kms;
  final String destination;

  EndMarkerPainter({required this.kms, required this.destination});
  @override
  void paint(Canvas canvas, Size size) {
    final blackPaint = Paint();
    blackPaint.color = Colors.black;
    final whitePaint = Paint();
    whitePaint.color = Colors.white;

    canvas.drawCircle(
        Offset(size.width - 20, size.height - 20), 20, blackPaint);

    canvas.drawCircle(Offset(size.width - 20, size.height - 20), 7, whitePaint);

    final path = Path();
    path.moveTo(10, 20);
    path.lineTo(size.width - 40, 20);
    path.lineTo(size.width - 40, size.height - 40);
    path.lineTo(10, size.height - 40);

    canvas.drawShadow(path, Colors.black, 10, false);
    canvas.drawPath(path, whitePaint);

    const blackBox = Rect.fromLTWH(210, 20, 110, 90);
    canvas.drawRect(blackBox, blackPaint);

    //text Palabla 55

    final textSpan = TextSpan(
        style: const TextStyle(
            fontSize: 35, color: Colors.white, fontWeight: FontWeight.w400),
        text: kms.toString());

    final minutesPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);
    minutesPainter.layout(minWidth: 70, maxWidth: 70);

    minutesPainter.paint(canvas, const Offset(230, 30));

    //palabla MIN
    const textSpan1 = TextSpan(
        style: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),
        text: 'KM');

    final minutesPainter1 = TextPainter(
        text: textSpan1,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);
    minutesPainter1.layout(minWidth: 70, maxWidth: 70);

    minutesPainter1.paint(canvas, const Offset(230, 70));

//Description

    final destinoText = destination;
    final locationText = TextSpan(
        style: const TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.w400),
        text: destinoText);

    final locationPainter = TextPainter(
      maxLines: 2,
      ellipsis: '...',
      text: locationText,
      textDirection: TextDirection.ltr,
    );
    locationPainter.layout(
        minWidth: size.width - 165, maxWidth: size.width - 165);

    final double offsetY = (destinoText.length > 20) ? 35 : 50;

    locationPainter.paint(canvas, Offset(20, offsetY));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
}
