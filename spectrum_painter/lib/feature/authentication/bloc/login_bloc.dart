import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spectrum_painter/common/repositories/authentication/login_repository.dart';

import '../../../common/common_constants.dart';
import '../../../common/utils/shared_preferences_service.dart';
import '../../../common/utils/validator.dart';
import '../model/authentication_model.dart';
import '../model/login_screen_state.dart';

abstract class LoginBloc extends Cubit<LoginScreenState> {
  LoginBloc() : super(LoginScreenState.defaultState);

  Future<void> login(AuthenticationModel user);

  void validate(AuthenticationModel user);

  ValueStream<LoginScreenState> get stateStream;
}

class LoginBlocImpl extends LoginBloc {
  LoginBlocImpl({required SharedPreferencesService sharedPreferencesService})
    : _sharedPreferencesService = sharedPreferencesService;

  final BehaviorSubject<LoginScreenState> _state = BehaviorSubject.seeded(
    LoginScreenState.defaultState,
  );

  final SharedPreferencesService _sharedPreferencesService;

  String? validateData(AuthenticationModel user) =>
      Validator.validateCredentials(user);

  @override
  ValueStream<LoginScreenState> get stateStream => _state.stream;

  @override
  Future<void> login(AuthenticationModel user) async {
    final String? validator = validateData(user);
    LoginScreenState currentState = _state.value;
    final isValidData = validator == null;
    late final String? loginResponse;
    currentState = currentState.copyWith(
      user: user,
      validationError: validator,
    );
    if (isValidData) {
      try {
        currentState = currentState.copyWith(
          loginButtonState: ButtonState.loading,
        );
        _state.add(currentState);

        if (validator == null) {
          loginResponse = await LoginRepository.instance.login(
            user.email!,
            user.password!,
          );
        }

        await _sharedPreferencesService.setSharedPrefsData(
          key: SharedPreferencesKeyConstants.loginKey,
          value: loginResponse != null,
        );

        final isUserLoggedIn = loginResponse != null;
        final loginButtonState = isUserLoggedIn
            ? ButtonState.success
            : ButtonState.fail;

        currentState = currentState.copyWith(
          isUserLoggedIn: isUserLoggedIn,
          loginButtonState: loginButtonState,
        );
      } on Exception catch (e) {
        debugPrint(e.toString());
        currentState = currentState.copyWith(
          isUserLoggedIn: false,
          loginButtonState: ButtonState.fail,
        );
      }
    }
    _state.add(currentState);
  }

  @override
  void validate(AuthenticationModel user) {
    final currentState = _state.value;
    final userData = currentState.user.copyWith(
      email: user.email,
      password: user.password,
    );
    final validationError = validateData(user);
    _state.add(
      currentState.copyWith(user: userData, validationError: validationError),
    );
  }
}
