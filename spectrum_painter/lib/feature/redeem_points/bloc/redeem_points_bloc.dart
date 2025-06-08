import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

import '../../../common/common_constants.dart';
import '../../../common/repositories/redeem_points/redeem_points_repository.dart';
import '../../../common/utils/shared_preferences_service.dart';
import '../model/redeem_points_state.dart';

abstract class RedeemPointsBloc extends Cubit<RedeemPointsScreenState> {
  RedeemPointsBloc() : super(RedeemPointsScreenState.defaultState);

  Future<void> redeemPoints(String points);

  ValueStream<RedeemPointsScreenState> get stateStream;
}

class RedeemPointsBlocImpl extends RedeemPointsBloc {
  RedeemPointsBlocImpl({
    required SharedPreferencesService sharedPreferencesService,
  }) : _sharedPreferencesService = sharedPreferencesService;

  final BehaviorSubject<RedeemPointsScreenState> _state =
      BehaviorSubject.seeded(RedeemPointsScreenState.defaultState);
  final SharedPreferencesService _sharedPreferencesService;

  @override
  ValueStream<RedeemPointsScreenState> get stateStream => _state.stream;

  @override
  Future<void> redeemPoints(String points) async {
    RedeemPointsScreenState currentState = _state.value;

    // Validate input
    if (points.isEmpty || int.tryParse(points) == null) {
      currentState = currentState.copyWith(
        success: false,
        errorText: 'Please enter a valid number',
      );
      _state.add(currentState);
      return;
    }

    // Set loading state
    currentState = currentState.copyWith(
      isLoading: true,
      errorText: '',
      success: false,
    );
    _state.add(currentState);

    final currentUser = _sharedPreferencesService.getStringData(
      SharedPreferencesKeyConstants.userIdKey,
    );

    // Handle missing user ID
    if (currentUser == null) {
      currentState = currentState.copyWith(
        isLoading: false,
        errorText: 'User ID not found',
        success: false,
      );
      _state.add(currentState);
      return;
    }

    try {
      final http.Response? response = await RedeemPointsRepository.instance
          .redeemPoints(currentUser, points);

      // Handle null response
      if (response == null) {
        currentState = currentState.copyWith(
          isLoading: false,
          errorText: 'No response from server.',
          success: false,
        );
        _state.add(currentState);
        return;
      }

      final statusCode = response.statusCode;
      final body = response.body;

      if (statusCode == 200) {
        currentState = currentState.copyWith(
          isLoading: false,
          success: true,
          errorText: '',
        );
      } else {
        final errorMessage = _parseErrorMessage(body);
        currentState = currentState.copyWith(
          isLoading: false,
          success: false,
          errorText: errorMessage,
        );
      }
    } catch (e) {
      currentState = currentState.copyWith(
        isLoading: false,
        success: false,
        errorText: 'Something went wrong. Please try again.',
      );
    }

    _state.add(currentState);
  }

  String _parseErrorMessage(String body) {
    try {
      final decoded = jsonDecode(body);
      return decoded['message'] ?? 'Unexpected error occurred.';
    } catch (_) {
      return 'Unexpected error occurred.';
    }
  }
}
