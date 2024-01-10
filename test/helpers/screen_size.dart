import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

extension ScreenSize on WidgetTester {
  void setScreenSize(Size size) {
    view.physicalSize = size;
    view.devicePixelRatio = 1.0;
    addTearDown(view.resetPhysicalSize);
  }
}
