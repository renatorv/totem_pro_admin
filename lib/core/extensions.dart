import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  bool get isSmalScreen => MediaQuery.sizeOf(this).width < 800;
}
