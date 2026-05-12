import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';

class MsCard extends StatelessWidget {
  const MsCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.border,
    this.background,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final BoxBorder? border;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: padding ?? const EdgeInsets.all(AppDimensions.paddingMd),
      child: child,
    );
    return Material(
      color: Colors.transparent,
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: background ?? AppColors.surfaceCard,
            borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
            border: border,
            boxShadow: const [
              BoxShadow(color: Color(0x141C2B6B), blurRadius: 4, offset: Offset(0, 1)),
            ],
          ),
          child: content,
        ),
      ),
    );
  }
}
