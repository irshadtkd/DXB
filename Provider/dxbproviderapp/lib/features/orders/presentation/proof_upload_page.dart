import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/utils/app_messenger.dart';
import '../../../core/widgets/app_widgets.dart';

class ProofUploadPage extends StatelessWidget {
  const ProofUploadPage({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.orderProofUpload)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(AppStrings.orderProofSubtitle),
          const SizedBox(height: 16),
          AppCard(
            child: ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: Text(AppStrings.uploadTap),
              onTap: () => showAppSnack(context, AppStrings.done),
            ),
          ),
          const SizedBox(height: 24),
          AppPrimaryButton(
            label: AppStrings.submit,
            onPressed: () {
              showAppSnack(context, AppStrings.done);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
