import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_messenger.dart';
import '../../../core/widgets/app_widgets.dart';
import 'review_detail_cubit.dart';

class ReviewDetailPage extends StatelessWidget {
  const ReviewDetailPage({super.key, required this.reviewId});

  final String reviewId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ReviewDetailCubit>()..load(reviewId),
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.reviewDetailTitle)),
        body: BlocConsumer<ReviewDetailCubit, ReviewDetailState>(
          listener: (c, s) {
            if (s is ReviewDetailFailure) showAppErrorBanner(c, s.failure.message);
          },
          builder: (c, s) {
            if (s is ReviewDetailLoading || s is ReviewDetailInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (s is ReviewDetailFailure) {
              return AppEmptyState(title: AppStrings.errorTitle, subtitle: s.failure.message, onRetry: () => c.read<ReviewDetailCubit>().load(reviewId));
            }
            if (s is ReviewDetailEmpty) {
              return AppEmptyState(title: AppStrings.emptyTitle, subtitle: AppStrings.emptySubtitle, onRetry: () => c.read<ReviewDetailCubit>().load(reviewId));
            }
            final d = (s as ReviewDetailLoaded).data;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(d['customer'] as String? ?? '', style: AppTextStyles.sora(fontSize: 20, fontWeight: FontWeight.w800)),
                Text(d['date'] as String? ?? '', style: AppTextStyles.dmSans(color: AppColors.textMuted)),
                const SizedBox(height: 12),
                Text(d['text'] as String? ?? '', style: AppTextStyles.dmSans(height: 1.5)),
                const SizedBox(height: 20),
                Text(AppStrings.reviewReply, style: AppTextStyles.sora(fontWeight: FontWeight.w700)),
                const TextField(maxLines: 3, decoration: InputDecoration()),
                const SizedBox(height: 12),
                AppPrimaryButton(label: AppStrings.reviewPostReply, onPressed: () => showAppSnack(context, AppStrings.done)),
              ],
            );
          },
        ),
      ),
    );
  }
}
