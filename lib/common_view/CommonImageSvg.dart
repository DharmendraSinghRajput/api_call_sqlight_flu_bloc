import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonImageSvg extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double borderRadius;
  final BoxShape shape;
  final bool crop;
  final VoidCallback? onTap;

  const CommonImageSvg({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 0,
    this.shape = BoxShape.rectangle,
    this.crop = false,
    this.onTap,
  });

  bool get _isSvg => imagePath.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    final Widget image = _isSvg
        ? SvgPicture.asset(
      imagePath,
      width: width,
      height: height,
      fit: fit,
    )
        : Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: fit,
    );

    Widget content;

    if (crop) {
      content = shape == BoxShape.circle
          ? ClipOval(child: image)
          : ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: image,
      );
    } else {
      content = Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: shape,
          borderRadius:
          shape == BoxShape.circle ? null : BorderRadius.circular(borderRadius),
        ),
        clipBehavior: shape == BoxShape.circle || borderRadius > 0
            ? Clip.antiAlias
            : Clip.none,
        child: image,
      );
    }

    return onTap != null
        ? GestureDetector(onTap: onTap, child: content)
        : content;
  }
}
