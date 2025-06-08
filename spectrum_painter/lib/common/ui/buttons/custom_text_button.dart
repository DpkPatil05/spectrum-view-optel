import 'package:flutter/material.dart';

import '../../common_constants.dart';
import '../../theme/theme_data.dart';
import '../loaders/circular_loading_indicator.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.color = ColorConstants.primaryTextColor,
    required this.text,
  });

  final Color color;
  final String text;
  final bool isLoading;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SizedBox(
            height: SpaceConstants.space16,
            width: SpaceConstants.space16,
            child: CircularLoadingIndicator(color: ColorConstants.primary),
          )
        : TextButton(
            onPressed: isLoading ? null : onPressed,
            autofocus: true,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                Colors.transparent,
              ),
            ),
            child: Text(
              text,
              style: CustomThemeData.defaultTextStyle.copyWith(
                shadows: [
                  Shadow(
                    color: color,
                    offset: const Offset(
                      SpaceConstants.zero,
                      -SpaceConstants.space6,
                    ),
                  ),
                ],
                color: Colors.transparent,
                decorationColor: color,
                decorationThickness: SpaceConstants.space4,
                decorationStyle: TextDecorationStyle.dotted,
              ),
            ),
          );
  }
}
