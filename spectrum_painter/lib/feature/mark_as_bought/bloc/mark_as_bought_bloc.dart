import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/mark_as_bought_state.dart';

abstract class MarkAsBoughtBloc extends Cubit<MarkAsBoughtScreenState> {
  MarkAsBoughtBloc() : super(MarkAsBoughtScreenState.defaultState);

  Future<void> markAsBought();
}

class MarkAsBoughtBlocImpl extends MarkAsBoughtBloc {
  @override
  Future<void> markAsBought() async {}
}
