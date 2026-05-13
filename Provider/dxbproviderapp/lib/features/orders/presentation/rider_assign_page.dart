import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_messenger.dart';
import '../../../core/widgets/app_widgets.dart';
import '../../orders/data/orders_repository.dart';

class RiderAssignPage extends StatefulWidget {
  const RiderAssignPage({super.key, required this.orderId});

  final String orderId;

  @override
  State<RiderAssignPage> createState() => _RiderAssignPageState();
}

class _RiderAssignPageState extends State<RiderAssignPage> {
  List<dynamic> _riders = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final list = await sl<OrdersRepository>().fetchRiders();
      setState(() {
        _riders = list;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      if (mounted) showAppErrorBanner(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.orderRiderTitle)),
      body: _loading
          ? ListView.builder(itemCount: 5, itemBuilder: (_, __) => const ShimmerListTile())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _riders.length,
              itemBuilder: (c, i) {
                final r = _riders[i] as Map<String, dynamic>;
                return AppCard(
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.two_wheeler)),
                    title: Text(r['name'] as String? ?? ''),
                    subtitle: Text('${r['vehicle']} · ETA ${r['eta']}', style: AppTextStyles.dmSans(fontSize: 12, color: AppColors.textSecondary)),
                    trailing: TextButton(
                      onPressed: () {
                        showAppSnack(context, AppStrings.done);
                        Navigator.of(context).pop();
                      },
                      child: Text(AppStrings.orderAssign),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
