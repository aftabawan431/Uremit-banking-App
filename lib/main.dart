import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'app/my_app.dart';
import 'utils/dependency_injection/dependency_injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    DevicePreview(
      builder: (context) => const MyApp(),
      enabled: false,
    ),
  );
}
