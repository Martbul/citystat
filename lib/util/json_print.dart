import 'dart:convert';

import 'package:citystat/packages/citystat_backend/lib/log.dart';
import 'package:flutter/material.dart';

const JsonEncoder _encoder = JsonEncoder.withIndent('  ');
void prettyPrintJson(Object? object) {
  Log.trace(_encoder.convert(object));
  debugPrint(_encoder.convert(object));
}
