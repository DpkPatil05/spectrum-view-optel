import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spectrum_painter/common/routes/routes.dart';

import '../../feature/authentication/bloc/login_bloc.dart';
import '../../feature/authentication/pages/login_screen_widget.dart';
import '../../feature/home/pages/home_screen_widget.dart';
import '../../feature/mark_as_bought/bloc/mark_as_bought_bloc.dart';
import '../../feature/mark_as_bought/pages/mark_as_bought_screen_widget.dart';
import '../../feature/redeem_points/bloc/redeem_points_bloc.dart';
import '../../feature/redeem_points/pages/redeem_points_screen_widget.dart';
import '../utils/shared_preferences_service.dart';

class AppRouteSequence {
  AppRouteSequence({required SharedPreferencesService sharedPreferencesService})
    : _sharedPreferencesService = sharedPreferencesService;

  final SharedPreferencesService _sharedPreferencesService;

  List<RouteBase> get _appRouteList => <RouteBase>[
    GoRoute(
      name: Routers.home.name,
      path: Routers.home.path,
      builder: (context, state) => const HomeScreenWidget(),
    ),
    GoRoute(
      name: Routers.redeem.name,
      path: Routers.redeem.path,
      builder: (context, state) => BlocProvider<RedeemPointsBloc>(
        create: (_) => RedeemPointsBlocImpl(
          sharedPreferencesService: _sharedPreferencesService,
        ),
        child: const RedeemPointsScreenWidget(),
      ),
    ),
    GoRoute(
      name: Routers.markBought.name,
      path: Routers.markBought.path,
      builder: (context, state) => BlocProvider<MarkAsBoughtBloc>(
        create: (_) => MarkAsBoughtBlocImpl(),
        child: const MarkAsBoughtScreenWidget(),
      ),
    ),
  ];

  Widget _rootWidget({required bool isLoginComplete}) =>
      isLoginComplete ? const HomeScreenWidget() : const LoginScreenWidget();

  List<BlocProvider> get _blocProvidersList => <BlocProvider>[
    BlocProvider<LoginBloc>(
      create: (_) =>
          LoginBlocImpl(sharedPreferencesService: _sharedPreferencesService),
    ),
    BlocProvider<RedeemPointsBloc>(
      create: (_) => RedeemPointsBlocImpl(
        sharedPreferencesService: _sharedPreferencesService,
      ),
    ),
    BlocProvider<MarkAsBoughtBloc>(create: (_) => MarkAsBoughtBlocImpl()),
  ];

  /// Initially the root path is set to [LoginScreenWidget]
  ///
  /// Once the login is complete,
  /// [HomeScreenWidget] is set as the root page.
  RouteBase rootPath({required bool isLoginComplete}) => GoRoute(
    name: Routers.root.name,
    path: Routers.root.path,
    routes: _appRouteList,
    builder: (context, _) {
      final size = MediaQuery.of(context).size;
      return Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: MultiBlocProvider(
            providers: _blocProvidersList,
            child: _rootWidget(isLoginComplete: isLoginComplete),
          ),
        ),
      );
    },
  );
}
