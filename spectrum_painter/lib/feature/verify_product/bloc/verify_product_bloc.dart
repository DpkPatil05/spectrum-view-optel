import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../common/repositories/verify_product/verify_product_repository.dart';
import '../model/verify_product_screen_state.dart';

abstract class VerifyProductBloc extends Cubit<VerifyProductScreenState> {
  VerifyProductBloc() : super(VerifyProductScreenState.defaultState);

  Future<void> verifyProduct(String serialNumber);

  ValueStream<VerifyProductScreenState> get stateStream;
}

class VerifyProductBlocImpl extends VerifyProductBloc {
  VerifyProductBlocImpl() : super();

  final BehaviorSubject<VerifyProductScreenState> _state =
      BehaviorSubject.seeded(VerifyProductScreenState.defaultState);

  @override
  ValueStream<VerifyProductScreenState> get stateStream => _state.stream;

  @override
  Future<void> verifyProduct(String url) async {
    _state.add(
      _state.value.copyWith(isLoading: true, errorText: '', isVerified: null),
    );

    try {
      final response = await VerifyProductRepository.instance.verifyProduct(
        url,
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

  String _parseErrorMessage(String body) {
    try {
      final decoded = jsonDecode(body);
      return decoded['message'] ?? 'Unexpected error occurred.';
    } catch (_) {
      return 'Unexpected error occurred.';
    }
  }
}
