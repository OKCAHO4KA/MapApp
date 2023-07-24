import 'package:flutter/material.dart';

class CustomSnackbar extends SnackBar {
  CustomSnackbar({
    Key? key,
    required String text,
    Duration duration = const Duration(milliseconds: 2000),
    String btnLabel = 'OK',
    void Function()? onPressed,
  }) : super(
            key: key,
            content: Text(text),
            duration: duration,
            action: SnackBarAction(
                label: btnLabel,
                onPressed: () {
                  if (onPressed != null) {
                    onPressed();
                  }
                }));
}
