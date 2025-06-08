import 'package:flutter/material.dart';

import '../../common_constants.dart';
import '../../theme/theme_data.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.onPressed,
    this.color,
    required this.text,
  });

  final String text;
  final Color? color;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      autofocus: true,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
          color ?? ColorConstants.tertiary,
        ),
        minimumSize: WidgetStateProperty.all<Size>(
          const Size(
            SpaceConstants.minimumButtonWidth,
            SpaceConstants.minimumButtonHeight,
          ),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          CustomThemeData.defaultRoundedRectangleBorder(),
        ),
        elevation: WidgetStateProperty.all<double>(
          SpaceConstants.defaultButtonElevation,
        ),
      ),
      child: Text(text, style: CustomThemeData.defaultTextStyle),
    );
  }
}
