import 'package:scaled_app/scaled_app.dart';

import 'package:flutter/material.dart';

import 'startup/startup.dart';
Future<void> main() async {
  ScaledWidgetsFlutterBinding.ensureInitialized(
    scaleFactor: (_) => 1.0,
  );

  await runAppCityStat();
}