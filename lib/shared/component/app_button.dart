import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_color.dart';

/// ✅ Main Reusable App Button
class AppButton extends StatefulWidget {
  final String title;
  final Future<void> Function()? onPressed;
  final Color bckgrndColor;
  final double borderRadius;
  final Color fontColor;
  final EdgeInsets padding;
  final bool loading;
  final double? width;
  final double fontSize;
  final Border? border;
  final Widget? leading;
  final bool enabled;

  const AppButton({
    super.key,
    required this.title,
    this.onPressed,
    this.bckgrndColor = AppColors.primaryBlue,
    this.borderRadius = 64,
    this.border,
    this.width,
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    this.fontSize = 16,
    this.loading = false,
    this.fontColor = Colors.white,
    this.leading,
    this.enabled = true,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _localLoading = false;

  bool get _isLoading => widget.loading || _localLoading;

  @override
  Widget build(BuildContext context) {
    final isInteractive = widget.onPressed != null && widget.enabled && !_isLoading;
    final activeColor = widget.bckgrndColor;
    final inactiveColor = widget.enabled ? activeColor : activeColor.withOpacity(1);

    return InkWell(
      borderRadius: BorderRadius.circular(widget.borderRadius.r),
      onTap: isInteractive
          ? () async {
        setState(() => _localLoading = true);
        try {
          await widget.onPressed?.call();
        } catch (e) {
          debugPrint('Error during button action: $e');
        }
        if (mounted) setState(() => _localLoading = false);
      }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          vertical: widget.padding.vertical.h,
          horizontal: widget.padding.horizontal.w,
        ),
        width: widget.width ?? double.infinity,
        decoration: BoxDecoration(
          color: _isLoading ? activeColor.withOpacity(0.7) : inactiveColor,
          border: widget.border,
          borderRadius: BorderRadius.circular(widget.borderRadius.r),
          boxShadow: isInteractive
              ? [
            BoxShadow(
              color: activeColor.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.leading != null && !_isLoading) ...[
              widget.leading!,
              SizedBox(width: 8.w),
            ],
            _isLoading
                ? SizedBox(
              width: 20.w,
              height: 20.h,
              child: CircularProgressIndicator(
                color: widget.fontColor,
                strokeWidth: 2.w,
              ),
            )
                : Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: widget.fontColor,
                fontSize: widget.fontSize.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ✅ Small Square Icon Button
class AppIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final double size;
  final bool enabled;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.backgroundColor = AppColors.primaryBlue,
    this.size = 40,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        width: size.w,
        height: size.h,
        decoration: BoxDecoration(
          color: enabled ? backgroundColor : backgroundColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.all(8.w),
        child: Center(child: icon),
      ),
    );
  }
}

/// ✅ Quick "Go Back" Button
class AppGoBackButton extends StatelessWidget {
  const AppGoBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      title: 'Go back',
      onPressed: () async => Navigator.pop(context),
      bckgrndColor: AppColors.lightGreen,
      borderRadius: 50,
    );
  }
}
