import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_color.dart';
import '../../core/constants/app_text_style.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.label,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.isRounded = false,
    this.counterText,
    this.controller,
    this.filledColor,
    this.readOnly = false,
    this.maxLines = 1,
    this.validator,
    this.autovalidateMode,
    this.prefixIcon,
    this.contentPadding = const EdgeInsets.fromLTRB(15, 15, 19, 15),
    this.borderSide,
    this.borderRadius = 10,
    this.hintColor = const Color(0xFFC4C4C4),
    this.borderColor,
    this.onTap,
    this.autofillHints,
    this.inputFormatters,
    this.minLines,
    this.textInputAction,
    this.fontColor,
  });

  final String? label;
  final bool isRounded;
  final String hintText;
  final String? counterText;
  final bool obscureText;
  final bool readOnly;
  final EdgeInsetsGeometry? contentPadding;
  final Color? filledColor;
  final Color? hintColor;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final BorderSide? borderSide;
  final double borderRadius;
  final TextAlign textAlign;
  final int? maxLength, maxLines, minLines;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final Iterable<String>? autofillHints;
  final Function()? onTap;
  final TextInputAction? textInputAction;
  final Color? borderColor;
  final Color? fontColor;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool obscureText = false;

  @override
  void initState() {
    obscureText = widget.obscureText;
    super.initState();
  }

  void _toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius.r),
      borderSide: widget.borderSide ??
          BorderSide(width: 1, color: widget.borderColor ?? AppColors.primaryGreen),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: AppTextStyles.bodyText.copyWith(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: AppColors.primaryGreen,
            ),
          ),
          3.verticalSpace,
        ],
        TextFormField(
          onTap: widget.onTap,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          onFieldSubmitted: widget.onFieldSubmitted,
          onChanged: widget.onChanged,
          obscureText: obscureText,
          readOnly: widget.readOnly,
          textAlign: widget.textAlign,
          autovalidateMode: widget.autovalidateMode,
          inputFormatters: widget.inputFormatters,
          maxLines: widget.maxLines,
          controller: widget.controller,
          maxLength: widget.maxLength,
          validator: widget.validator,
          minLines: widget.minLines,
          focusNode: widget.focusNode,
          textInputAction: widget.textInputAction,
          keyboardType: widget.keyboardType,
          style: AppTextStyles.bodyText.copyWith(
            fontWeight: FontWeight.w500,
            color: widget.fontColor ?? Colors.black,
          ),
          cursorColor: AppColors.primaryGreen,
          decoration: InputDecoration(
            suffixIcon: widget.obscureText
                ? GestureDetector(
              onTap: _toggleObscureText,
              child: Icon(
                obscureText
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.primaryGreen,
                size: 19,
              ),
            )
                : widget.suffixIcon,
            prefixIcon: widget.prefixIcon,
            contentPadding: widget.contentPadding,
            hintText: widget.hintText,
            counterText: widget.counterText,
            counterStyle: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            border: outlineInputBorder,
            fillColor: widget.filledColor ?? Colors.grey.shade200,
            filled: true,
            focusedBorder: outlineInputBorder.copyWith(
              borderSide: BorderSide(color: AppColors.primaryGreen, width: 1.5),
            ),
            enabledBorder: outlineInputBorder,
            hintStyle: AppTextStyles.bodyText.copyWith(
              color: widget.hintColor ?? Colors.grey.shade500,
            ),
          ),
          autofillHints: widget.autofillHints,
        ),
      ],
    );
  }
}
