import 'package:flutter/material.dart';

import '../../utils/platform.dart';

class PlatformAdaptiveIcon extends StatelessWidget {
  const PlatformAdaptiveIcon({
    required this.materialIcon,
    required this.cupertinoIcon,
    this.size,
    this.semanticLabel,
    this.color,
    super.key,
  });

  final IconData materialIcon;
  final IconData cupertinoIcon;
  final String? semanticLabel;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Icon(
      isCupertino ? cupertinoIcon : materialIcon,
      semanticLabel: semanticLabel,
      size: size,
      color: color,
    );
  }
}
