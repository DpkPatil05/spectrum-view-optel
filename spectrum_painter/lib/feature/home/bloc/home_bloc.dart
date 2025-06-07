import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../common/utils/shared_preferences_service.dart';
import '../model/home_screen_state.dart';

abstract class HomeBloc extends Cubit<HomeScreenState?> {
  HomeBloc(super.initialState);

  ValueStream<HomeScreenState> get stateStream;

  void onTabSelect(int index);
}

class HomeBlocImpl extends HomeBloc {
  HomeBlocImpl(
    super.initialState, {
    required SharedPreferencesService sharedPreferencesService,
  }) : _sharedPreferencesService = sharedPreferencesService;

  final SharedPreferencesService _sharedPreferencesService;
  final BehaviorSubject<HomeScreenState> _state = BehaviorSubject.seeded(
    HomeScreenState.defaultState,
  );

  @override
  ValueStream<HomeScreenState> get stateStream => _state.stream;

  @override
  void onTabSelect(int index) {
    final currentState = _state.value;
    _state.add(currentState.copyWith(activeTab: TabOption.values[index]));
  }
}
