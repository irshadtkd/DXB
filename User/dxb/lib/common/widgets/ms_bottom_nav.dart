import 'package:flutter/material.dart';

import '../../core/strings/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class MsBottomNav extends StatelessWidget {
  const MsBottomNav({
    super.key,
    required this.currentIndex,
    required this.onSelect,
    this.savedInsteadOfExplore = false,
  });

  final int currentIndex;
  final ValueChanged<int> onSelect;
  final bool savedInsteadOfExplore;

  @override
  Widget build(BuildContext context) {
    final items = [
      _Item(Icons.home_outlined, Icons.home, AppStrings.navHome),
      _Item(Icons.receipt_long_outlined, Icons.receipt_long, AppStrings.navOrders),
      _Item(
        savedInsteadOfExplore ? Icons.favorite_border : Icons.search,
        savedInsteadOfExplore ? Icons.favorite : Icons.search,
        savedInsteadOfExplore ? AppStrings.navSaved : AppStrings.navExplore,
      ),
      _Item(Icons.person_outline, Icons.person, AppStrings.navProfile),
    ];
    return Material(
      elevation: 8,
      color: AppColors.surfaceCard,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 10, 4, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final it = items[i];
              final active = i == currentIndex;
              return InkWell(
                onTap: () => onSelect(i),
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        active ? it.filled : it.outlined,
                        size: 22,
                        color: active ? AppColors.primary : AppColors.onSurface3,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        it.label,
                        style: AppTextStyles.navLabel(
                          color: active ? AppColors.primary : AppColors.onSurface3,
                          weight: active ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _Item {
  const _Item(this.outlined, this.filled, this.label);
  final IconData outlined;
  final IconData filled;
  final String label;
}
