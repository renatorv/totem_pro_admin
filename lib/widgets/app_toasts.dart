import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Function showLoading() {
  return BotToast.showCustomLoading(
    toastBuilder: (_) {
      return Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: const SpinKitCubeGrid(color: Colors.blue),
      );
    },
  );
}

Function showError(
  String message, {
  Duration duration = const Duration(seconds: 3),
}) {
  return BotToast.showText(
    text: message,
    contentColor: Colors.red,
    duration: duration,
  );
}

Function showSuccess(
  String message, {
  Duration duration = const Duration(seconds: 3),
}) {
  return BotToast.showText(
    text: message,
    contentColor: Colors.blue,
    duration: duration,
  );
}
