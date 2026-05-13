import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_messenger.dart';
import '../../../core/widgets/app_widgets.dart';
import 'inbox_cubit.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<InboxCubit>()..load(),
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.inboxTitle)),
        body: BlocConsumer<InboxCubit, InboxState>(
          listener: (context, state) {
            if (state is InboxFailure) showAppErrorBanner(context, state.failure.message);
          },
          builder: (context, state) {
            if (state is InboxLoading || state is InboxInitial) {
              return ListView.builder(itemCount: 6, itemBuilder: (_, __) => const ShimmerListTile());
            }
            if (state is InboxFailure) {
              return AppEmptyState(title: AppStrings.errorTitle, subtitle: state.failure.message, onRetry: () => context.read<InboxCubit>().load());
            }
            if (state is InboxEmpty) {
              return AppEmptyState(title: AppStrings.emptyTitle, subtitle: AppStrings.emptySubtitle, onRetry: () => context.read<InboxCubit>().load());
            }
            final threads = (state as InboxLoaded).threads;
            return ListView.builder(
              itemCount: threads.length,
              itemBuilder: (c, i) {
                final t = threads[i] as Map<String, dynamic>;
                final unread = t['unread'] as int? ?? 0;
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(t['title'] as String? ?? ''),
                  subtitle: Text(t['preview'] as String? ?? '', maxLines: 1, overflow: TextOverflow.ellipsis),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(t['time'] as String? ?? '', style: AppTextStyles.dmSans(fontSize: 11, color: AppColors.textMuted)),
                      if (unread > 0) AppBadge(label: '$unread', variant: AppBadgeVariant.primary),
                    ],
                  ),
                  onTap: () => context.push('/inbox/chat/${t['id']}'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
