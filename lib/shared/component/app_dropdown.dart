import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_color.dart';

class AppDropdown<T> extends StatelessWidget {
  final String? label;
  final String hintText;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final String? Function(T?)? validator;
  final bool isExpanded;
  final Widget? prefixIcon;

  const AppDropdown({
    super.key,
    this.label,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.value,
    this.validator,
    this.isExpanded = true,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black,
            ),
          ),
          8.verticalSpace,
        ],
        DropdownButtonFormField<T>(
          value: value,
          items: items,
          validator: validator,
          isExpanded: isExpanded,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: AppColors.black,
            ),
            enabledBorder: _buildBorder(const Color(0xFF7E93A0)),
            focusedBorder: _buildBorder(AppColors.primaryGreen, width: 1.5),
            prefixIcon: prefixIcon,
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }

  /// Builds the same style border as AppTextfield for UI consistency
  OutlineInputBorder _buildBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: width),
      borderRadius: BorderRadius.circular(16.r),
    );
  }
}
