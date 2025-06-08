import 'package:flutter/material.dart';
import 'package:spectrum_painter/common/routes/routes.dart';
import 'package:spectrum_painter/common/theme/theme_data.dart';

import 'common_constants.dart';

class AppLauncher extends StatelessWidget {
  const AppLauncher({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: StringConstants.appName,
      theme: CustomThemeData.defaultTheme,
      routerConfig: Routes.router,
    );
  }
}
