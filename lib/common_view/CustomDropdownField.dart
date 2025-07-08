import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final List<String> items;
  final String? selectedItem;
  final Function(String?) onChanged;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;
  final EdgeInsets padding;
  final double height;
  final double? width;
  final IconData? prefixIcon;
  final Widget? dropdownIcon;
  final Color backgroundColor;
  final String? hint; // New field for hint

  const CustomDropdownField({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    this.borderRadius = 8.0,
    this.borderColor = Colors.grey,
    this.borderWidth = 1.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 0),
    this.height = 48.0,
    this.width,
    this.prefixIcon,
    this.dropdownIcon,
    this.backgroundColor = Colors.transparent,
    this.hint, // Include in constructor
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        width: width ?? double.infinity,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          children: [
            if (prefixIcon != null) ...[
              Icon(prefixIcon, color: Colors.grey),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: items.contains(selectedItem) ? selectedItem : null,
                  hint: hint != null ? Text(hint!) : null,
                  isExpanded: true,
                  icon: dropdownIcon ?? const Icon(Icons.arrow_drop_down),
                  items: items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: onChanged,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
