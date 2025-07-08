import 'package:flutter/material.dart';

class CommonImage extends StatelessWidget {
  final String imagePath;
  final double? width;         // nullable
  final double? height;        // nullable
  final BoxFit fit;
  final double borderRadius;
  final BoxShape shape;
  final bool crop;

  const CommonImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 0,
    this.shape = BoxShape.rectangle,
    this.crop = false,
  });

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: fit,
    );

    if (crop) {
      if (shape == BoxShape.circle) {
        return ClipOval(child: image);
      } else {
        return ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: image,
        );
      }
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: shape,
        borderRadius:
        shape == BoxShape.circle ? null : BorderRadius.circular(borderRadius),
      ),
      child: image,
    );
  }
}
