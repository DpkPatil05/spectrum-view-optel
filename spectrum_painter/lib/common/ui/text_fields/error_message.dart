import 'package:flutter/material.dart';

import '../../common_constants.dart';
import '../../theme/theme_data.dart';

class CustomErrorMessage extends StatelessWidget {
  const CustomErrorMessage({super.key, this.text, required this.icon});

  final String? text;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: SpaceConstants.space6),
          child: icon,
        ),
        Text(
          text ?? '',
          style: CustomThemeData.defaultTextStyle.copyWith(
            color: ColorConstants.error,
          ),
        ),
      ],
    );
  }
}
