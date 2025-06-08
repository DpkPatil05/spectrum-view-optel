import 'package:flutter/material.dart';

import '../../../common/common_constants.dart';
import '../../../common/theme/theme_data.dart';

class LoginScreenWidget extends StatefulWidget {
  const LoginScreenWidget({super.key});

  @override
  State<LoginScreenWidget> createState() => _LoginScreenWidgetState();
}

class _LoginScreenWidgetState extends State<LoginScreenWidget> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                color: ColorConstants.primary.withOpacity(0.25),
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
                controller: emailController,
                hintText: StringConstants.enterEmail,
              ),
              const SizedBox(height: SpaceConstants.space20),
              _buildTextField(
                controller: passwordController,
                hintText: StringConstants.enterPassword,
                obscureText: true,
              ),
              const SizedBox(height: SpaceConstants.space30),
              SizedBox(
                width: double.infinity,
                height: SpaceConstants.minimumButtonHeight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.primary,
                    shape: CustomThemeData.defaultRoundedRectangleBorder(),
                  ),
                  onPressed: () {
                    // TODO: Connect to bloc login
                  },
                  child: Text(
                    StringConstants.login.toUpperCase(),
                    style: CustomThemeData.titleTextStyle.copyWith(
                      color: ColorConstants.primaryTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextField _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: CustomThemeData.defaultTextStyle,
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
