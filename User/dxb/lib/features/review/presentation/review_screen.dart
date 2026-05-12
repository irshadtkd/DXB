import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/ms_app_bar.dart';
import '../../../common/widgets/ms_safe_body.dart';
import '../../../common/widgets/ms_primary_button.dart';
import '../../../common/widgets/ms_secondary_button.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key, required this.orderId});

  final String orderId;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  double _rating = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: MsAppBar(title: AppStrings.reviewTitle),
      body: MsSafeBody(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(AppStrings.reviewOrderLabel(widget.orderId), style: AppTextStyles.bodySm(color: AppColors.onSurface3)),
              const SizedBox(height: 16),
              Slider(value: _rating, min: 1, max: 5, divisions: 8, label: _rating.toStringAsFixed(1), onChanged: (v) => setState(() => _rating = v)),
              const Spacer(),
              MsPrimaryButton(label: AppStrings.reviewSubmit, onPressed: () => context.pop()),
              const SizedBox(height: 10),
              MsSecondaryButton(label: AppStrings.reviewSkip, onPressed: () => context.pop(), expanded: true),
            ],
          ),
        ),
      ),
    );
  }
}
