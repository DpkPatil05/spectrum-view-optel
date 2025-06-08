import 'package:flutter/material.dart';

import '../../common_constants.dart';
import '../../theme/theme_data.dart';

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({
    super.key,
    this.defaultText,
    this.hintText,
    this.obscureText = false,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onTap,
    this.focusNode,
    required this.controller,
    required this.label,
    required this.suffixIcon,
  });

  final bool obscureText;
  final String label;
  final Icon suffixIcon;
  final TextEditingController controller;
  final String? defaultText;
  final String? hintText;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: ColorConstants.tertiary,
        primaryColorDark: ColorConstants.tertiary,
      ),
      child: TextFormField(
        controller: controller,
        initialValue: defaultText,
        obscureText: obscureText,
        focusNode: focusNode,
        onTap: onTap,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onFieldSubmitted,
        cursorColor: ColorConstants.primaryTextColor,
        style: CustomThemeData.defaultTextStyle,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: SpaceConstants.space24),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: SpaceConstants.space20),
            child: suffixIcon,
          ),
          focusedBorder: CustomThemeData.defaultOutlineInputBorder(
            color: ColorConstants.secondary,
          ),
          hintText: hintText,
          labelText: label,
          labelStyle: CustomThemeData.defaultTextStyle,
          enabledBorder: CustomThemeData.defaultOutlineInputBorder(),
        ),
      ),
    );
  }
}
