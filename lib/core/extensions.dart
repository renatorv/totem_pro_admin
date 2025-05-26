import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  bool get isMobile => MediaQuery.sizeOf(this).width < 800;
}
