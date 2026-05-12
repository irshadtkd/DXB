import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_text_styles.dart';

class MsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MsAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.centerTitle = true,
    this.gradient,
  });

  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;
  final Gradient? gradient;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 4);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      color: gradient == null ? AppColors.surfaceCard : Colors.transparent,
      child: Container(
        decoration: gradient != null
            ? BoxDecoration(gradient: gradient)
            : const BoxDecoration(
                color: AppColors.surfaceCard,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x141C2B6B),
                    blurRadius: 4,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
        child: SafeArea(
          bottom: false,
          child: SizedBox(
            height: kToolbarHeight,
            child: NavigationToolbar(
              leading: leading ??
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: gradient != null ? Colors.white : null),
                    onPressed: () => Navigator.maybePop(context),
                  ),
              middle: Text(
                title,
                style: AppTextStyles.displayMd(
                  color: gradient != null ? Colors.white : AppColors.onSurface,
                ),
                textAlign: centerTitle ? TextAlign.center : TextAlign.start,
              ),
              trailing: actions != null && actions!.isNotEmpty
                  ? Row(mainAxisSize: MainAxisSize.min, children: actions!)
                  : null,
              centerMiddle: centerTitle,
            ),
          ),
        ),
      ),
    );
  }
}

class MsBackButton extends StatelessWidget {
  const MsBackButton({super.key, this.onTap, this.light = false});

  final VoidCallback? onTap;
  final bool light;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: light ? Colors.white.withValues(alpha: 0.15) : AppColors.surfaceMuted,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap ?? () => Navigator.maybePop(context),
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          width: AppDimensions.backButton,
          height: AppDimensions.backButton,
          child: Icon(
            Icons.arrow_back,
            size: AppDimensions.iconSm,
            color: light ? Colors.white : AppColors.onSurface2,
          ),
        ),
      ),
    );
  }
}
