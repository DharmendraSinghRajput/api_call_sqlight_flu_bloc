import 'package:flutter/material.dart';

enum GradientDirection { horizontal, vertical }

class CommanButtonCricle extends StatelessWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final BoxShape shape;
  final Widget? child;
  final List<Color> gradientColors;
  final GradientDirection gradientDirection;
  final VoidCallback? onTap; // <-- added onTap callback

  const CommanButtonCricle({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 0,
    this.shape = BoxShape.rectangle,
    this.child,
    required this.gradientColors,
    this.gradientDirection = GradientDirection.horizontal,
    this.onTap, // <-- added here
  });

  @override
  Widget build(BuildContext context) {
    Alignment begin = gradientDirection == GradientDirection.horizontal
        ? Alignment.centerLeft
        : Alignment.topCenter;
    Alignment end = gradientDirection == GradientDirection.horizontal
        ? Alignment.centerRight
        : Alignment.bottomCenter;

    return GestureDetector(
      onTap: onTap, // <-- handle click here
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: shape,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: begin,
            end: end,
          ),
          borderRadius:
          shape == BoxShape.circle ? null : BorderRadius.circular(borderRadius),
        ),
        child: Center(child: child),
      ),
    );
  }
}
