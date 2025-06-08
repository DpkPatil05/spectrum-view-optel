import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/redeem_points_state.dart';

abstract class RedeemPointsBloc extends Cubit<RedeemPointsScreenState> {
  RedeemPointsBloc() : super(RedeemPointsScreenState.defaultState);

  Future<void> redeemPoints();
}

class RedeemPointsBlocImpl extends RedeemPointsBloc {
  @override
  Future<void> redeemPoints() async {}
}
