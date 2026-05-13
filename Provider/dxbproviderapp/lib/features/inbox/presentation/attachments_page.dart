import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_widgets.dart';

class AttachmentsPage extends StatelessWidget {
  const AttachmentsPage({super.key, required this.threadId});

  final String threadId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.attachmentsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppCard(
            child: ListTile(
              leading: const Icon(Icons.image_outlined),
              title: Text(AppStrings.uploadTap, style: AppTextStyles.dmSans(fontWeight: FontWeight.w700)),
              subtitle: Text(AppStrings.threadLabel(threadId), style: AppTextStyles.dmSans(fontSize: 12, color: AppColors.textMuted)),
            ),
          ),
        ],
      ),
    );
  }
}
