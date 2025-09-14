import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_color.dart';

class AppTextfield extends StatefulWidget {
  final String? label;
  final String hintText;
  final TextEditingController? controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final VoidCallback? onTap;
  final bool readOnly;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  /// Regular constructor for standard text fields
  const AppTextfield.regular({
    super.key,
    this.label,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.readOnly = false,
    this.validator,
    this.onChanged,
  }) : isPassword = false;

  /// Constructor specifically for password fields
  const AppTextfield.password({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  })  : isPassword = true,
        suffixIcon = null,
        prefixIcon = null,
        onTap = null,
        readOnly = false;

  @override
  State<AppTextfield> createState() => _AppTextfieldState();
}

class _AppTextfieldState extends State<AppTextfield> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_refreshOnTextChange);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_refreshOnTextChange);
    super.dispose();
  }

  void _refreshOnTextChange() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black,
            ),
          ),
          8.verticalSpace,
        ],
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscureText : false,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: AppColors.black,
            ),
            enabledBorder: _buildBorder(const Color(0xFF7E93A0)),
            focusedBorder: _buildBorder(AppColors.primaryGreen, width: 1.5),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isPassword
                ? _buildPasswordToggle()
                : widget.suffixIcon,
          ),
        ),
      ],
    );
  }

  /// Builds the border style for the textfield
  OutlineInputBorder _buildBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: width),
      borderRadius: BorderRadius.circular(16.r),
    );
  }

  /// Builds the toggle icon for password fields
  Widget _buildPasswordToggle() {
    return IconButton(
      icon: Icon(
        _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        color: Colors.black,
      ),
      onPressed: () => setState(() => _obscureText = !_obscureText),
    );
  }
}
