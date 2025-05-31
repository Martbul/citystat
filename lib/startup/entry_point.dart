import 'package:citystat/startup/launch_configuration.dart';
import 'package:citystat/startup/startup.dart';
import 'package:citystat/user/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class CityStatApplication implements EntryPoint {
  @override
  Widget create(LaunchConfiguration config) {
    return SplashScreen(isAnon: config.isAnon);
  }
}