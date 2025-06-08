import 'package:flutter/material.dart';

import '../../common_constants.dart';

class CircularLoadingIndicator extends StatelessWidget {
  const CircularLoadingIndicator({
    super.key,
    this.color,
    this.downloadProgress,
  });

  final double? downloadProgress;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? ColorConstants.primary,
        strokeWidth: SpaceConstants.progressLoaderThickness,
        value: downloadProgress,
      ),
    );
  }
}
