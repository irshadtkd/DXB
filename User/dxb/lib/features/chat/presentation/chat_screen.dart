import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/ms_app_bar.dart';
import '../../../common/widgets/ms_safe_body.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/util/load_status.dart';
import 'cubit/chat_cubit.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.threadId});

  final String threadId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatCubit(sl(), threadId)..load(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: MsAppBar(title: AppStrings.chatTitle),
        body: MsSafeBody(
          top: false,
          bottom: false,
          child: BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
            if (state.status != LoadStatus.success || state.thread == null) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }
            final t = state.thread!;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text('${t.providerName} · ${t.status}', style: AppTextStyles.bodySm(color: AppColors.onSurface3)),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: t.messages.length,
                    itemBuilder: (_, i) {
                      final m = t.messages[i];
                      final align = m.fromUser ? Alignment.centerRight : Alignment.centerLeft;
                      final bg = m.fromUser ? AppColors.primary : AppColors.surfaceMuted;
                      final fg = m.fromUser ? Colors.white : AppColors.onSurface;
                      return Align(
                        alignment: align,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.78),
                          decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(AppDimensions.radiusMd)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(m.text, style: AppTextStyles.bodyMd(color: fg)),
                              Text(m.time, style: AppTextStyles.displayXs(color: fg.withValues(alpha: 0.7))),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Expanded(child: TextField(decoration: InputDecoration(hintText: AppStrings.chatHint))),
                        IconButton(onPressed: () {}, icon: const Icon(Icons.send, color: AppColors.primary)),
                      ],
                    ),
                  ),
                ),
              ],
            );
            },
          ),
        ),
      ),
    );
  }
}
