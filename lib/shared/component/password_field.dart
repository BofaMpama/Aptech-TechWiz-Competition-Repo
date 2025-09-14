import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_color.dart';

class PasswordField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final TextEditingController? passwordController; // Only used for confirm password
  final bool isConfirmField;
  final String? Function(String?)? customValidator;
  final ValueChanged<String>? onChanged;
  final Widget? prefixIcon;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? label;

  const PasswordField({
    super.key,
    required this.hintText,
    required this.controller,
    this.passwordController,
    this.isConfirmField = false,
    this.customValidator,
    this.onChanged,
    this.prefixIcon,
    this.readOnly = false,
    this.onTap,
    this.label,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        if (widget.label != null && widget.label!.isNotEmpty) ...[
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: Text(
              widget.label!,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: AppColors.lightGreen,
              ),
            ),
          ),
          SizedBox(height: 3.h),
        ],

        // Password Field
        TextFormField(
          controller: widget.controller,
          obscureText: !_isPasswordVisible,
          keyboardType: TextInputType.visiblePassword,
          validator: (value) {
            // Custom validation first
            if (widget.customValidator != null) {
              final customResult = widget.customValidator!(value);
              if (customResult != null) return customResult;
            }

            // Confirm password validation logic
            if (widget.isConfirmField) {
              if (value == null || value.isEmpty) {
                return "Please confirm your password";
              }
              if (widget.passwordController != null &&
                  value != widget.passwordController!.text) {
                return "Passwords do not match";
              }
            } else {
              // Normal password validation
              if (value == null || value.isEmpty) {
                return "Password is required";
              }
              if (value.length < 6) {
                return "Password must be at least 6 characters";
              }
            }
            return null;
          },
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: 16.sp,
              color: const Color(0xFFC4C4C4),
            ),
            enabledBorder: _buildBorder(const Color(0xFF153121)),
            focusedBorder: _buildBorder(AppColors.primaryGreen, width: 1.5),
            errorBorder: _buildBorder(Colors.red),
            focusedErrorBorder: _buildBorder(Colors.red, width: 1.5),
            filled: true,
            fillColor: Colors.grey.shade200,
            contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
            prefixIcon: widget.prefixIcon,
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: AppColors.primaryBlue,
                size: 20.sp,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _buildBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: width),
      borderRadius: BorderRadius.circular(15.r),
    );
  }
}