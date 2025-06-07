import 'package:progress_state_button/progress_button.dart';

import 'authentication_model.dart';

class LoginScreenState {
  LoginScreenState({
    this.validationError,
    this.loginButtonState = ButtonState.idle,
    required this.user,
    required this.isUserLoggedIn,
  });

  final AuthenticationModel user;
  final bool isUserLoggedIn;
  final ButtonState loginButtonState;
  final String? validationError;

  static LoginScreenState get defaultState => LoginScreenState(
    user: AuthenticationModel(),
    validationError: null,
    isUserLoggedIn: false,
    loginButtonState: ButtonState.idle,
  );

  LoginScreenState copyWith({
    AuthenticationModel? user,
    String? validationError,
    bool? isUserLoggedIn,
    ButtonState? loginButtonState,
  }) => LoginScreenState(
    user: user ?? this.user,
    loginButtonState: loginButtonState ?? this.loginButtonState,
    validationError: validationError ?? this.validationError,
    isUserLoggedIn: isUserLoggedIn ?? this.isUserLoggedIn,
  );
}
