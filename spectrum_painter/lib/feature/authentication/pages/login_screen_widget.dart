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
                    _buildTextField(
                      controller: _emailController,
                      hintText: StringConstants.enterEmail,
                    ),
                    const SizedBox(height: SpaceConstants.space20),
                    _buildTextField(
                      controller: _passwordController,
                      hintText: StringConstants.enterPassword,
                      obscureText: true,
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
      /// This delay is to hold the screen for [SpaceConstants.defaultDelay]
      /// to show success.
      /// This is just for better UX.
      ///
      /// Duration is 4s.
      Future.delayed(
        const Duration(seconds: SpaceConstants.defaultDelay),
      ).whenComplete(() => context.pushReplacement('/${Routers.home.path}'));
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

  TextField _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: CustomThemeData.defaultTextStyle,
      cursorColor: ColorConstants.primaryTextColor,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: SpaceConstants.space20),
        hintText: hintText,
        hintStyle: TextStyle(color: ColorConstants.secondaryTextColor),
        enabledBorder: CustomThemeData.defaultOutlineInputBorder(),
        focusedBorder: CustomThemeData.defaultOutlineInputBorder(
          color: ColorConstants.primaryWhite,
        ),
        filled: true,
        fillColor: ColorConstants.secondary,
      ),
    );
  }
}
