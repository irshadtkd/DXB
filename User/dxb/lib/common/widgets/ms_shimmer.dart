import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';

class MsShimmer extends StatelessWidget {
  const MsShimmer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.surfaceDim,
      highlightColor: AppColors.surfaceCard,
      child: child,
    );
  }
}

class MsListTileShimmer extends StatelessWidget {
  const MsListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return MsShimmer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.surfaceMuted,
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 14, width: double.infinity, color: AppColors.surfaceMuted),
                  const SizedBox(height: 8),
                  Container(height: 12, width: 120, color: AppColors.surfaceMuted),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MsCardShimmer extends StatelessWidget {
  const MsCardShimmer({super.key, this.height = 120});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: MsShimmer(
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: AppColors.surfaceMuted,
            borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
          ),
        ),
      ),
    );
  }
}
