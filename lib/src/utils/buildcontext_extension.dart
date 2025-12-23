import 'package:flutter/widgets.dart';

extension BuildContextExtensions on BuildContext {
  bool get isRTL => Directionality.of(this) == TextDirection.rtl;
  bool get isLTR => Directionality.of(this) == TextDirection.ltr;
}
