import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  bool get isSmallScreen => MediaQuery.sizeOf(this).width < 800;
}
