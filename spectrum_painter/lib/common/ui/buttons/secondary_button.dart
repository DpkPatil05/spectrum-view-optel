import 'package:flutter/material.dart';

import '../../common_constants.dart';
import '../../theme/theme_data.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({super.key, this.onPressed, required this.text});

  final String text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      autofocus: true,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
          ColorConstants.secondary,
        ),
        minimumSize: WidgetStateProperty.all<Size>(
          const Size(
            SpaceConstants.minimumButtonWidth,
            SpaceConstants.minimumButtonHeight,
          ),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          CustomThemeData.defaultRoundedRectangleBorder(
            color: ColorConstants.primary,
          ),
        ),
        elevation: WidgetStateProperty.all<double>(
          SpaceConstants.defaultButtonElevation,
        ),
      ),
      child: Text(
        text,
        style: CustomThemeData.defaultTextStyle.copyWith(
          color: ColorConstants.primaryTextColor,
        ),
      ),
    );
  }
}
