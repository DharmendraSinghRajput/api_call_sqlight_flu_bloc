import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String checkedIconPath;
  final String uncheckedIconPath;
  final double? width;
  final double? height;

  const CustomSvgCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.checkedIconPath,
    required this.uncheckedIconPath,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics( // For accessibility (optional)
      label: 'Custom Checkbox',
      checked: value,
      child: InkWell(
        onTap: () => onChanged(!value),
        borderRadius: BorderRadius.circular(4), // Optional: gives ripple effect a shape
        child: Padding(
          padding: const EdgeInsets.all(4.0), // Optional: improves tap area
          child: SvgPicture.asset(
            value ? checkedIconPath : uncheckedIconPath,
            width: width,
            height: height,
          ),
        ),
      ),
    );
  }
}
