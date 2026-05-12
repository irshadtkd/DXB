import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/ms_app_bar.dart';
import '../../../common/widgets/ms_safe_body.dart';
import '../../../common/widgets/ms_card.dart';
import '../../../common/widgets/ms_primary_button.dart';
import '../../../common/widgets/ms_secondary_button.dart';
import '../../../common/widgets/ms_text_field.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/util/load_status.dart';
import '../../../domain/entities/entities.dart';
import 'cubit/laundry_schedule_cubit.dart';

class LaundryScheduleScreen extends StatelessWidget {
  const LaundryScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LaundryScheduleCubit(sl())..load(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: MsAppBar(title: AppStrings.laundryScheduleTitle),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Row(
              children: [
                Expanded(child: MsSecondaryButton(label: AppStrings.laundryCancel, onPressed: () => context.pop())),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: MsPrimaryButton(
                    label: AppStrings.laundrySchedulePickup,
                    icon: const Icon(Icons.schedule, color: Colors.white, size: 18),
                    onPressed: () => context.push(RoutePaths.laundrySummary),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: MsSafeBody(
          top: false,
          bottom: false,
          child: BlocBuilder<LaundryScheduleCubit, LaundryScheduleState>(
            builder: (context, state) {
            if (state.status == LoadStatus.loading) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }
            if (state.status == LoadStatus.failure || state.base == null) {
              return Center(child: Text(state.message ?? AppStrings.commonErrorTitle));
            }
            final b = state.base!;
            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
              children: [
                Text(AppStrings.laundryPickupAddress, style: _sectionLabel),
                const SizedBox(height: 8),
                MsCard(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on, color: AppColors.sage),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(b.addressTitle, style: AppTextStyles.bodyMd(weight: FontWeight.w600)),
                            Text(b.addressSubtitle, style: AppTextStyles.bodySm()),
                          ],
                        ),
                      ),
                      const Icon(Icons.edit, color: AppColors.primary),
                    ],
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add_circle, color: AppColors.primary, size: 18),
                  label: Text(AppStrings.laundryAddAddress, style: AppTextStyles.bodyMd(color: AppColors.primary, weight: FontWeight.w600)),
                ),
                const SizedBox(height: 8),
                Text(AppStrings.laundryPickupDate, style: _sectionLabel),
                const SizedBox(height: 8),
                SizedBox(
                  height: 78,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: b.dates.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (_, i) {
                      final d = b.dates[i];
                      final sel = i == state.selectedDateIndex;
                      return GestureDetector(
                        onTap: () => context.read<LaundryScheduleCubit>().selectDate(i),
                        child: Container(
                          width: 58,
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                          decoration: BoxDecoration(
                            color: sel ? AppColors.primary : AppColors.surfaceCard,
                            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                            border: Border.all(color: sel ? AppColors.primary : AppColors.outline, width: 1.5),
                          ),
                          child: Column(
                            children: [
                              Text(d.weekday, style: AppTextStyles.displayXs(color: sel ? Colors.white70 : AppColors.onSurface3)),
                              Text('${d.day}', style: AppTextStyles.displayLg(color: sel ? Colors.white : AppColors.onSurface, weight: FontWeight.w800)),
                              Text(d.month, style: AppTextStyles.displayXs(color: sel ? Colors.white70 : AppColors.onSurface3)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Text(AppStrings.laundryTimeSlot, style: _sectionLabel),
                const SizedBox(height: 8),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 3.2,
                  children: b.timeSlots.map((t) {
                    final sel = t.id == state.selectedSlotId;
                    return InkWell(
                      onTap: () => context.read<LaundryScheduleCubit>().selectSlot(t.id),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: sel ? AppColors.primary : AppColors.surfaceCard,
                          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                          border: Border.all(color: sel ? AppColors.primary : AppColors.outline, width: 1.5),
                        ),
                        child: Center(
                          child: Text(t.label, style: AppTextStyles.bodySm(color: sel ? Colors.white : AppColors.onSurface2, weight: FontWeight.w600)),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Text(AppStrings.laundryType, style: _sectionLabel),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: b.laundryTypes.map((t) {
                    final sel = state.selectedTypeIds.contains(t.id);
                    return FilterChip(
                      label: Text(t.label),
                      selected: sel,
                      onSelected: (_) => context.read<LaundryScheduleCubit>().toggleType(t.id),
                      selectedColor: AppColors.primary,
                      checkmarkColor: Colors.white,
                      labelStyle: AppTextStyles.chip(color: sel ? Colors.white : AppColors.onSurface2),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Text(AppStrings.laundryQuantity, style: _sectionLabel),
                const SizedBox(height: 8),
                MsCard(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(b.weightLabel, style: AppTextStyles.bodyMd(weight: FontWeight.w600)),
                            Text(b.weightHint, style: AppTextStyles.bodySm()),
                          ],
                        ),
                      ),
                      IconButton(onPressed: () => context.read<LaundryScheduleCubit>().bumpWeight(-1), icon: const Icon(Icons.remove)),
                      Text('${state.weightUnits}', style: AppTextStyles.displaySm(color: AppColors.primary, weight: FontWeight.w800)),
                      IconButton(
                        style: IconButton.styleFrom(backgroundColor: AppColors.primary),
                        onPressed: () => context.read<LaundryScheduleCubit>().bumpWeight(1),
                        icon: const Icon(Icons.add, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(AppStrings.laundryInstructions, style: _sectionLabel),
                const SizedBox(height: 8),
                MsTextField(hint: AppStrings.laundryInstructionsHint, prefixIcon: Icons.notes, maxLines: 3),
                const SizedBox(height: 16),
                MsCard(
                  onTap: () {},
                  child: Row(
                    children: [
                      const Icon(Icons.local_offer, color: AppColors.primary),
                      const SizedBox(width: 10),
                      Expanded(child: Text(AppStrings.laundryAddCoupon, style: AppTextStyles.bodyMd(color: AppColors.primary, weight: FontWeight.w600))),
                      const Icon(Icons.chevron_right, color: AppColors.primary),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.surfaceMuted, borderRadius: BorderRadius.circular(AppDimensions.radiusLg)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(AppStrings.laundryEstimated, style: AppTextStyles.bodyMd(weight: FontWeight.w700)),
                      const SizedBox(height: 10),
                      ...b.estimateLines.map((e) => Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(e.label, style: AppTextStyles.bodySm(color: AppColors.onSurface2)),
                                Text(
                                  e.value,
                                  style: AppTextStyles.bodySm(
                                    weight: FontWeight.w600,
                                    color: e.highlight == 'sage' ? AppColors.sage : AppColors.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          )),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppStrings.commonTotal, style: AppTextStyles.bodyMd(weight: FontWeight.w700)),
                          Text(b.totalEstimate, style: AppTextStyles.displaySm(color: AppColors.primary, weight: FontWeight.w800)),
                        ],
                      ),
                      Text(AppStrings.laundryEstDisclaimer, style: AppTextStyles.displayXs()),
                    ],
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

final TextStyle _sectionLabel = AppTextStyles.displayXs(color: AppColors.onSurface2);
