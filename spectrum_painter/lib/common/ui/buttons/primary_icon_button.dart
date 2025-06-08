import 'package:flutter/material.dart';

import '../../common_constants.dart';
import '../loaders/circular_loading_indicator.dart';

class PrimaryIconButton extends StatelessWidget {
  const PrimaryIconButton({
    super.key,
    this.onPressed,
    this.iconSize = SpaceConstants.space34,
    this.color = ColorConstants.primaryWhite,
    this.isLoading = false,
    required this.icon,
  });

  final IconData icon;
  final bool isLoading;
  final Color color;
  final double iconSize;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SpaceConstants.roundedButtonHeight,
      width: SpaceConstants.roundedButtonWidth,
      child: IconButton(
        icon: isLoading ? const CircularLoadingIndicator() : Icon(icon),
        iconSize: iconSize,
        color: color,
        disabledColor: ColorConstants.buttonDisabledColor,
        splashColor: ColorConstants.primary,
        onPressed: isLoading ? null : onPressed,
      ),
    );
  }
}
