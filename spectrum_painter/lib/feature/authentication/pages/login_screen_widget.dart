import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:rxdart/rxdart.dart';

import '../../../common/common_constants.dart';
import '../../../common/routes/routes.dart';
import '../../../common/theme/theme_data.dart';
import '../../../common/ui/buttons/primary_loading_button.dart';
import '../../../common/ui/text_fields/error_message.dart';
import '../../../common/ui/text_fields/primary_text_field.dart';
import '../bloc/login_bloc.dart';
import '../model/authentication_model.dart';
import '../model/login_screen_state.dart';

class LoginScreenWidget extends StatefulWidget {
  const LoginScreenWidget({super.key});

  @override
  State<LoginScreenWidget> createState() => _LoginScreenWidgetState();
}

class _LoginScreenWidgetState extends State<LoginScreenWidget> {
  late final LoginBloc bloc;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final BehaviorSubject<ButtonState> _buttonStateController =
      BehaviorSubject<ButtonState>.seeded(ButtonState.idle);

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<LoginBloc>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LoginScreenState>(
      stream: bloc.stateStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final data = snapshot.requireData;
          final isValidState = data.validationError == null;
          _setLoginButtonState(data.loginButtonState);
          return Scaffold(
            backgroundColor: ColorConstants.tertiary,
            body: Center(
              child: Container(
                padding: const EdgeInsets.all(SpaceConstants.space24),
                margin: const EdgeInsets.all(SpaceConstants.space16),
                decoration: BoxDecoration(
                  color: ColorConstants.primaryTransparent,
                  borderRadius: BorderRadius.circular(
                    SpaceConstants.defaultCornerRadius,
                  ),
                  border: Border.all(color: ColorConstants.tertiary, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstants.primary.withAlpha(
                        (0.25 * 255).round(),
                      ),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomThemeData.headerText(text: StringConstants.login),
                    const SizedBox(height: SpaceConstants.space20),

                    /// Email text input field
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: SpaceConstants.space40,
                      ),
                      child: PrimaryTextField(
                        controller: _emailController,
                        label: StringConstants.email,
                        hintText: StringConstants.enterEmail,
                        focusNode: _emailFocusNode,
                        onEditingComplete: _onEditingComplete,
                        suffixIcon: Icon(LucideIcons.mail),
                      ),
                    ),

                    /// Password text input field
                    PrimaryTextField(
                      controller: _passwordController,
                      label: StringConstants.password,
                      hintText: StringConstants.enterPassword,
                      obscureText: true,
                      focusNode: _passwordFocusNode,
                      onEditingComplete: _onEditingComplete,
                      suffixIcon: Icon(LucideIcons.key),
                    ),

                    /// Error text
                    _buildErrorText(
                      isValidState: isValidState,
                      validationError: data.validationError,
                    ),
                    const SizedBox(height: SpaceConstants.space20),
                    SizedBox(
                      width: double.infinity,
                      height: SpaceConstants.minimumButtonHeight,
                      child: PrimaryLoadingButton(
                        text: ' ${StringConstants.login}',
                        icon: LucideIcons.logIn,
                        buttonStateController: _buttonStateController,
                        onPressed: _handleLogin,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  void _onEditingComplete() {
    _unFocusAllNodes();
    bloc.validate(
      AuthenticationModel(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  void _unFocusAllNodes() => FocusScope.of(context).unfocus();

  Future<void> _handleLogin() async {
    final loginData = AuthenticationModel(
      email: _emailController.text,
      password: _passwordController.text,
    );
    await bloc
        .login(loginData)
        .whenComplete(() => _setScreenStateAsPerAuthentication(context));
  }

  void _setLoginButtonState(ButtonState loginButtonState) {
    return switch (loginButtonState) {
      ButtonState.idle => _buttonStateController.add(ButtonState.idle),
      ButtonState.loading => _buttonStateController.add(ButtonState.loading),
      ButtonState.success => _buttonStateController.add(ButtonState.success),
      ButtonState.fail => _buttonStateController.add(ButtonState.fail),
    };
  }

  void _setScreenStateAsPerAuthentication(BuildContext context) {
    final data = bloc.stateStream.value;
    final isUserLoggedIn = data.isUserLoggedIn;
    if (isUserLoggedIn && context.mounted) {
      context.pushReplacement('/${Routers.home.path}');
    }
  }

  Column _buildErrorText({
    required bool isValidState,
    String? validationError,
  }) => Column(
    children: [
      /// Error message
      Padding(
        padding: const EdgeInsets.symmetric(vertical: SpaceConstants.space8),
        child: Visibility(
          visible: !isValidState,
          child: CustomErrorMessage(
            text: validationError,
            icon: Icon(Icons.error),
          ),
        ),
      ),
    ],
  );
}
