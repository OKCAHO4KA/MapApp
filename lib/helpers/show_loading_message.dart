import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoadingMessage(BuildContext context) {
  if (Platform.isAndroid) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const AlertDialog(
            title: Text('Espere...'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Calculando la ruta'),
                SizedBox(
                  height: 15,
                ),
                CircularProgressIndicator(
                  strokeWidth: 7,
                  color: Color.fromRGBO(236, 158, 76, 1),
                )
              ],
            )));
    return;
  }
  showCupertinoDialog(
      context: context,
      builder: (context) => const CupertinoAlertDialog(
            title: Text('Espere...'),
            content: CupertinoActivityIndicator(),
          ));
  return;
}
