import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
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

    // Update initial state with user and validation result
    currentState = currentState.copyWith(
      user: user,
      validationError: validator,
    );
    _state.add(currentState);

    // Proceed only if local validation passed
    if (!isValidData) return;

    try {
      currentState = currentState.copyWith(
        loginButtonState: ButtonState.loading,
      );
      _state.add(currentState);

      final http.Response? response = await LoginRepository.instance.login(
        user.email!,
        user.password!,
      );

      // Handle null response
      if (response == null) {
        currentState = currentState.copyWith(
          loginButtonState: ButtonState.fail,
          isUserLoggedIn: false,
          validationError: "Unable to connect to server.",
        );
        _state.add(currentState);
        return;
      }

      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      final bool isSuccess =
          response.statusCode == 200 && responseBody['success'] == true;
      final String? serverError = responseBody['message'];

      // Save login state only if success
      if (isSuccess) {
        await _sharedPreferencesService.setSharedPrefsData(
          key: SharedPreferencesKeyConstants.loginKey,
          value: true,
        );
      }

      currentState = currentState.copyWith(
        isUserLoggedIn: isSuccess,
        loginButtonState: isSuccess ? ButtonState.success : ButtonState.fail,
        validationError: isSuccess ? null : (serverError ?? "Login failed"),
      );
    } catch (e) {
      debugPrint('Login Exception: $e');
      currentState = currentState.copyWith(
        isUserLoggedIn: false,
        loginButtonState: ButtonState.fail,
        validationError: "Something went wrong. Please try again.",
      );
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
