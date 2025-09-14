import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pawfect/shared/component/app_input.dart';

import '../../core/constants/app_color.dart';
import '../../core/constants/app_text_style.dart';

class PageInput extends StatelessWidget {
  const PageInput({
    super.key,
    required this.hint,
    required this.label,
    this.prefix,
    this.suffix,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.maxLength,
    this.maxLines = 1,
    this.autovalidateMode,
    this.readOnly = false,
    this.dropDownItems,
    this.onDropdownChanged,
    this.onChanged,
    this.hintColor = const Color(0xFFC4C4C4),
    this.labelColor = AppColors.lightGreen,
    this.contentPadding,
    this.borderRadius,
    this.onTap,
    this.autofillHints,
    this.inputFormatters,
    this.minLines,
    this.textInputAction,
    this.filledColor,
    this.borderColor = const Color(0xFF153121),
    this.fontColor = AppColors.black,
    this.isCompulsory = false,
  });

  final String hint;
  final String label;
  final Widget? prefix, suffix;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText, readOnly, isCompulsory;
  final int maxLines;
  final int? maxLength, minLines;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final List<DropdownMenuItem<dynamic>>? dropDownItems;
  final Function(dynamic)? onDropdownChanged;
  final Function(String)? onChanged;
  final Color? hintColor, labelColor, filledColor, borderColor, fontColor;
  final EdgeInsetsGeometry? contentPadding;
  final Iterable<String>? autofillHints;
  final double? borderRadius;
  final Function()? onTap;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Label with optional compulsory star (*)
        if (label.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: AppTextStyles.bodyText.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: labelColor,
                  ),
                ),
                if (isCompulsory) ...[
                  SizedBox(width: 5.w),
                  Text(
                    "*",
                    style: AppTextStyles.bodyText.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                ]
              ],
            ),
          ),
        SizedBox(height: 3.h),

        /// Input field
        AppTextField(
          onTap: onTap,
          filledColor: filledColor,
          hintText: hint,
          keyboardType: keyboardType,
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          autovalidateMode: autovalidateMode,
          readOnly: readOnly,
          prefixIcon: prefix,
          suffixIcon: suffix,
          onChanged: onChanged,
          hintColor: hintColor,
          borderColor: borderColor,
          fontColor: fontColor,
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
          borderRadius: borderRadius ?? 15.r,
          autofillHints: autofillHints,
          textInputAction: textInputAction,
          minLines: minLines,
          maxLines: maxLines,
          inputFormatters: inputFormatters,
          maxLength: maxLength,
        ),
      ],
    );
  }
}