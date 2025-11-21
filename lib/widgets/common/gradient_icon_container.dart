import 'package:flutter/material.dart';
import '../../constants/app_dimens.dart';

class GradientIconContainer extends StatelessWidget {
  const GradientIconContainer({
    super.key,
    required this.icon,
    required this.colors,
    this.size = AppDimens.iconXXLarge,
    this.padding = AppDimens.paddingMedium,
    this.borderRadius = AppDimens.radiusXLarge,
  });

  final IconData icon;
  final List<Color> colors;
  final double size;
  final double padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Icon(icon, color: Colors.white, size: size),
    );
  }
}
