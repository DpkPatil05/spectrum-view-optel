import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../common/common_constants.dart';
import '../../../common/repositories/mark_as_bought/mark_as_bought_repository.dart';
import '../../../common/repositories/verify_product/verify_product_repository.dart';
import '../../../common/utils/shared_preferences_service.dart';
import '../model/mark_as_bought_state.dart';

abstract class MarkAsBoughtBloc extends Cubit<MarkAsBoughtScreenState> {
  MarkAsBoughtBloc() : super(MarkAsBoughtScreenState.defaultState);

  Future<void> verifyProduct(String serialNumber);

  Future<void> markAsBought(String serialNumber);

  ValueStream<MarkAsBoughtScreenState> get stateStream;
}

class MarkAsBoughtBlocImpl extends MarkAsBoughtBloc {
  MarkAsBoughtBlocImpl({
    required SharedPreferencesService sharedPreferencesService,
  }) : _sharedPreferencesService = sharedPreferencesService;

  final BehaviorSubject<MarkAsBoughtScreenState> _state =
      BehaviorSubject.seeded(MarkAsBoughtScreenState.defaultState);
  final SharedPreferencesService _sharedPreferencesService;

  @override
  ValueStream<MarkAsBoughtScreenState> get stateStream => _state.stream;

  @override
  Future<void> verifyProduct(String serialNumber) async {
    _state.add(
      _state.value.copyWith(
        isLoading: true,
        errorText: '',
        isVerified: null,
        isBought: null,
      ),
    );

    try {
      final response = await VerifyProductRepository.instance.verifyProduct(
        serialNumber,
      );

      if (response == null) {
        _state.add(
          _state.value.copyWith(
            isLoading: false,
            errorText: 'No response from server.',
            success: false,
          ),
        );
        return;
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        _state.add(
          _state.value.copyWith(
            isLoading: false,
            isVerified: true,
            success: true,
            errorText: '',
          ),
        );
      } else {
        final message = _parseErrorMessage(response.body);
        _state.add(
          _state.value.copyWith(
            isLoading: false,
            errorText: message,
            isVerified: false,
            success: false,
          ),
        );
      }
    } catch (e) {
      _state.add(
        _state.value.copyWith(
          isLoading: false,
          errorText: 'Something went wrong. Please try again.',
          success: false,
          isVerified: false,
        ),
      );
    }
  }

  @override
  Future<void> markAsBought(String serialNumber) async {
    _state.add(
      _state.value.copyWith(
        isLoading: true,
        errorText: '',
        isBought: null,
        isVerified: null,
      ),
    );

    final email = _sharedPreferencesService.getStringData(
      SharedPreferencesKeyConstants.userIdKey,
    );

    if (email == null) {
      _state.add(
        _state.value.copyWith(
          isLoading: false,
          errorText: 'User ID not found.',
          success: false,
        ),
      );
      return;
    }

    try {
      final response = await MarkAsBoughtRepository.instance.markAsBought(
        email,
        serialNumber,
      );

      if (response == null) {
        _state.add(
          _state.value.copyWith(
            isLoading: false,
            errorText: 'No response from server.',
            success: false,
          ),
        );
        return;
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        _state.add(
          _state.value.copyWith(
            isLoading: false,
            isBought: true,
            success: true,
            errorText: '',
          ),
        );
      } else {
        final message = _parseErrorMessage(response.body);
        _state.add(
          _state.value.copyWith(
            isLoading: false,
            errorText: message,
            isBought: false,
            success: false,
          ),
        );
      }
    } catch (e) {
      _state.add(
        _state.value.copyWith(
          isLoading: false,
          errorText: 'Something went wrong. Please try again.',
          success: false,
          isBought: false,
        ),
      );
    }
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
