import 'package:go_router/go_router.dart';

import '../common_constants.dart';
import '../utils/shared_preferences_service.dart';
import 'app_route_sequence.dart';

class Routes {
  static final SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesServiceImpl();

  /// Get login status data from SharedPreference.
  static bool get _isLoginComplete =>
      _sharedPreferencesService.getBoolData(
        SharedPreferencesKeyConstants.loginKey,
      ) ??
      false;

  /// Route configurations
  static GoRouter router = GoRouter(
    routes: <RouteBase>[
      // On app launch | Startup sequence
      AppRouteSequence(
        sharedPreferencesService: _sharedPreferencesService,
      ).rootPath(isLoginComplete: _isLoginComplete),
    ],
  );
}

enum Routers { root, home, verify, markBought, redeem }

extension RoutersExtension on Routers {
  String get path {
    return switch (this) {
      Routers.root => RouteConstants.root,
      Routers.home => RouteConstants.home,
      Routers.verify => RouteConstants.verify,
      Routers.markBought => RouteConstants.markBought,
      Routers.redeem => RouteConstants.redeem,
    };
  }
}
