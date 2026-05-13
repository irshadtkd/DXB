import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/constants/provider_categories.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_widgets.dart';
import '../../session/presentation/session_cubit.dart';

class RegisterBusinessPage extends StatefulWidget {
  const RegisterBusinessPage({super.key});

  @override
  State<RegisterBusinessPage> createState() => _RegisterBusinessPageState();
}

class _RegisterBusinessPageState extends State<RegisterBusinessPage> {
  final _name = TextEditingController();
  final _license = TextEditingController();
  final _address = TextEditingController();
  final _city = TextEditingController();
  final Set<String> _selected = {};

  @override
  void initState() {
    super.initState();
    final existing = context.read<SessionCubit>().state.providerCategoryIds;
    _selected.addAll(existing);
  }

  @override
  void dispose() {
    _name.dispose();
    _license.dispose();
    _address.dispose();
    _city.dispose();
    super.dispose();
  }

  String _labelFor(String id) {
    switch (id) {
      case ProviderCategoryIds.food:
        return AppStrings.registerCategoryFood;
      case ProviderCategoryIds.laundry:
        return AppStrings.registerCategoryLaundry;
      case ProviderCategoryIds.rental:
        return AppStrings.registerCategoryRental;
      case ProviderCategoryIds.homeServices:
        return AppStrings.registerCategoryHomeServices;
      default:
        return id;
    }
  }

  Future<void> _next() async {
    if (_selected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(AppStrings.registerCategoriesRequired)));
      return;
    }
    await context.read<SessionCubit>().setProviderCategories(_selected.toList());
    if (!mounted) return;
    context.push('/register/documents');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.registerBusinessTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(AppStrings.registerBusinessSubtitle, style: AppTextStyles.dmSans(color: AppColors.textSecondary, height: 1.4)),
          const SizedBox(height: 20),
          Text(AppStrings.registerSelectServicesTitle, style: AppTextStyles.sora(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text(AppStrings.registerSelectServicesSubtitle, style: AppTextStyles.dmSans(fontSize: 12, color: AppColors.textSecondary, height: 1.4)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ProviderCategoryIds.all.map((id) {
              final on = _selected.contains(id);
              return FilterChip(
                label: Text(_labelFor(id)),
                selected: on,
                onSelected: (v) => setState(() {
                  if (v) {
                    _selected.add(id);
                  } else {
                    _selected.remove(id);
                  }
                }),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          TextField(controller: _name, decoration: const InputDecoration(labelText: AppStrings.fieldBusinessName)),
          const SizedBox(height: 12),
          TextField(controller: _license, decoration: const InputDecoration(labelText: AppStrings.fieldTradeLicense)),
          const SizedBox(height: 12),
          TextField(controller: _address, decoration: const InputDecoration(labelText: AppStrings.fieldAddress)),
          const SizedBox(height: 12),
          TextField(controller: _city, decoration: const InputDecoration(labelText: AppStrings.fieldCity)),
          const SizedBox(height: 24),
          AppPrimaryButton(label: AppStrings.next, onPressed: _next),
        ],
      ),
    );
  }
}
