import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_color.dart';

class ImageHelper {
  static Widget svgImage(
      String path, {
        double? width,
        double? height,
        Color? color,
        BoxFit? fit,
      }) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      color: color,
      package: null,
      fit: fit ?? BoxFit.contain,
    );
  }

  static Widget normalImage(
      String path, {
        double? width,
        double? height,
        Color? color,
        BoxFit? fit,
      }) {
    return Image.asset(
      path,
      width: width,
      height: height,
      color: color,
      package: null,
      fit: fit,
    );
  }

  static Widget buildNetworkImage(
      String? url, {
        double? height,
        double? width,
      }) {
    if (url == null || url.isEmpty) return const SizedBox();

    final isSvg = url.toLowerCase().endsWith('.svg');

    return isSvg
        ? SvgPicture.network(
      url,
      height: height,
      width: width,
      fit: BoxFit.cover,
      placeholderBuilder:
          (context) => Center(
        child: Column(
          children: [
            60.verticalSpace,
            CircularProgressIndicator(
              color: AppColors.primaryBlue,
            ),
            60.verticalSpace,
          ],
        ),
      ),
    )
        : Image.network(
      url,
      height: height,
      width: width,
      fit: BoxFit.cover,
      errorBuilder:
          (context, error, stackTrace) =>
      const Center(child: Icon(Icons.broken_image)),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: Column(
            children: [
              60.verticalSpace,
              CircularProgressIndicator(color: AppColors.primaryBlue),
              60.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}

class _FadingPlaceholder extends StatefulWidget {
  final double? height;
  final double? width;

  const _FadingPlaceholder({this.height, this.width});

  @override
  State<_FadingPlaceholder> createState() => _FadingPlaceholderState();
}

class _FadingPlaceholderState extends State<_FadingPlaceholder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween(begin: 0.3, end: 0.7).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
