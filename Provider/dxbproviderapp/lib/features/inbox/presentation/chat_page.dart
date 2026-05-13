import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_messenger.dart';
import '../../../core/widgets/app_widgets.dart';
import 'chat_cubit.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key, required this.threadId});

  final String threadId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ChatCubit>()..load(threadId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.chatTitle),
          actions: [
            IconButton(
              icon: const Icon(Icons.attach_file),
              onPressed: () => context.push('/inbox/chat/$threadId/attachments'),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) {
                  if (state is ChatFailure) showAppErrorBanner(context, state.failure.message);
                },
                builder: (context, state) {
                  if (state is ChatLoading || state is ChatInitial) {
                    return ListView.builder(itemCount: 4, itemBuilder: (_, __) => const ShimmerListTile());
                  }
                  if (state is ChatFailure) {
                    return AppEmptyState(title: AppStrings.errorTitle, subtitle: state.failure.message, onRetry: () => context.read<ChatCubit>().load(threadId));
                  }
                  final msgs = (state as ChatLoaded).messages;
                  if (msgs.isEmpty) {
                    return AppEmptyState(title: AppStrings.emptyTitle, subtitle: AppStrings.emptySubtitle, onRetry: () => context.read<ChatCubit>().load(threadId));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: msgs.length,
                    itemBuilder: (c, i) {
                      final m = msgs[i] as Map<String, dynamic>;
                      final from = m['from'] as String? ?? '';
                      final mine = from == 'provider';
                      return Align(
                        alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(12),
                          constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.78),
                          decoration: BoxDecoration(
                            color: mine ? AppColors.primary : AppColors.bgCard,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Text(
                            m['text'] as String? ?? '',
                            style: AppTextStyles.dmSans(color: mine ? Colors.white : AppColors.textPrimary),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const _ChatComposer(),
          ],
        ),
      ),
    );
  }
}

class _ChatComposer extends StatefulWidget {
  const _ChatComposer();

  @override
  State<_ChatComposer> createState() => _ChatComposerState();
}

class _ChatComposerState extends State<_ChatComposer> {
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _ctrl,
                decoration: InputDecoration(hintText: AppStrings.typeMessage, filled: true),
              ),
            ),
            IconButton(
              onPressed: () {
                if (_ctrl.text.isEmpty) return;
                showAppSnack(context, AppStrings.send);
                _ctrl.clear();
              },
              icon: const Icon(Icons.send_rounded),
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
