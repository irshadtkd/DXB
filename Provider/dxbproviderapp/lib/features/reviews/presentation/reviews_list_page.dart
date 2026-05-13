import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_messenger.dart';
import '../../../core/widgets/app_widgets.dart';
import 'reviews_list_cubit.dart';

class ReviewsListPage extends StatelessWidget {
  const ReviewsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ReviewsListCubit>()..load(),
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.reviewsTitle)),
        body: BlocConsumer<ReviewsListCubit, ReviewsListState>(
          listener: (c, s) {
            if (s is ReviewsListFailure) showAppErrorBanner(c, s.failure.message);
          },
          builder: (c, s) {
            if (s is ReviewsListLoading || s is ReviewsListInitial) {
              return ListView.builder(itemCount: 5, itemBuilder: (_, __) => const ShimmerListTile());
            }
            if (s is ReviewsListFailure) {
              return AppEmptyState(title: AppStrings.errorTitle, subtitle: s.failure.message, onRetry: () => c.read<ReviewsListCubit>().load());
            }
            if (s is ReviewsListEmpty) {
              return AppEmptyState(title: AppStrings.emptyTitle, subtitle: AppStrings.emptySubtitle, onRetry: () => c.read<ReviewsListCubit>().load());
            }
            final items = (s as ReviewsListLoaded).items;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (c, i) {
                final r = items[i] as Map<String, dynamic>;
                return ListTile(
                  leading: CircleAvatar(child: Text('${r['rating']}')),
                  title: Text(r['customer'] as String? ?? ''),
                  subtitle: Text(r['text'] as String? ?? '', maxLines: 2, overflow: TextOverflow.ellipsis),
                  trailing: Text(r['date'] as String? ?? '', style: AppTextStyles.dmSans(fontSize: 11, color: AppColors.textMuted)),
                  onTap: () => context.push('/account/reviews/${r['id']}'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
