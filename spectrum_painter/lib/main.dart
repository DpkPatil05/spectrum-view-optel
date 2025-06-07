import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'common/app_launcher.dart';
import 'common/repositories/shared_preference_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await SharedPreferenceRepository.init();
  runApp(const AppLauncher());
}
