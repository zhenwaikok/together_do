import 'package:flutter/material.dart';

mixin CheckMountedMixin on ChangeNotifier {
  bool _mounted = true;
  bool get mounted => _mounted;

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
  }
}
