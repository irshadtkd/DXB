import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/ms_bottom_nav.dart';
import '../../../common/widgets/ms_card.dart';
import '../../../common/widgets/ms_error_state.dart';
import '../../../common/widgets/ms_loader.dart';
import '../../../common/widgets/ms_primary_button.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/util/load_status.dart';
import '../../../domain/entities/entities.dart';
import 'cubit/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, this.embeddedInShell = false});

  final bool embeddedInShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      bottomNavigationBar: embeddedInShell
          ? null
          : MsBottomNav(
              currentIndex: 3,
              onSelect: (i) {
                if (i == 0) context.go(RoutePaths.hub);
                if (i == 1) context.go(RoutePaths.ordersTab);
                if (i == 2) context.go(RoutePaths.explore);
              },
            ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state.status == LoadStatus.loading) return const MsLoader();
          if (state.status == LoadStatus.failure) {
            return MsErrorState(message: state.message ?? '', onRetry: () => context.read<ProfileCubit>().retry());
          }
          final profile = state.profile!;
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _Header(profile: profile)),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    MsCard(
                      padding: EdgeInsets.zero,
                      child: Column(
                        children: [
                          _Tile(icon: Icons.location_on, iconBg: AppColors.primaryDim, iconColor: AppColors.primary, title: AppStrings.profileAddresses, onTap: () {}),
                          const Divider(height: 1),
                          _Tile(
                            icon: Icons.payment,
                            iconBg: AppColors.accentLight,
                            iconColor: AppColors.accent,
                            title: AppStrings.profilePayments,
                            onTap: () => context.push(RoutePaths.wallet),
                          ),
                          const Divider(height: 1),
                          _Tile(
                            icon: Icons.local_offer,
                            iconBg: AppColors.sageLight,
                            iconColor: AppColors.sage,
                            title: AppStrings.profileVouchers,
                            badge: '${profile.voucherBadge} NEW',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    MsCard(
                      padding: EdgeInsets.zero,
                      child: Column(
                        children: [
                          _Tile(
                            icon: Icons.notifications,
                            iconBg: AppColors.homeServicePurpleBg,
                            iconColor: AppColors.homeServicePurple,
                            title: AppStrings.profileNotifications,
                            onTap: () => context.push(RoutePaths.notifications),
                          ),
                          const Divider(height: 1),
                          _Tile(icon: Icons.privacy_tip, iconBg: AppColors.surfaceMuted, iconColor: AppColors.onSurface2, title: AppStrings.profilePrivacy, onTap: () {}),
                          const Divider(height: 1),
                          _Tile(
                            icon: Icons.help,
                            iconBg: AppColors.surfaceMuted,
                            iconColor: AppColors.onSurface2,
                            title: AppStrings.profileHelp,
                            onTap: () => context.push(RoutePaths.help),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [AppColors.accent, Color(0xFFE8942A)]),
                        borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
                      ),
                      child: Row(
                        children: [
                          const Text('🎁', style: TextStyle(fontSize: 36)),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppStrings.profileReferTitle, style: AppTextStyles.displaySm(color: Colors.white, weight: FontWeight.w800)),
                                Text(AppStrings.profileReferBody, style: AppTextStyles.bodySm(color: Colors.white.withValues(alpha: 0.85))),
                              ],
                            ),
                          ),
                          FilledButton(
                            onPressed: () {},
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.accentDark,
                              shape: const StadiumBorder(),
                            ),
                            child: Text(AppStrings.profileInvite, style: AppTextStyles.bodySm(weight: FontWeight.w700)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    MsPrimaryButton(
                      label: AppStrings.profileSignOut,
                      onPressed: () => context.go(RoutePaths.login),
                    ),
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.profile});
  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final p = profile;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.splashGradientStart, AppColors.splashGradientMid]),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppStrings.profileTitle, style: AppTextStyles.displayMd(color: Colors.white)),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        const Icon(Icons.edit, size: 16, color: Colors.white),
                        const SizedBox(width: 6),
                        Text(AppStrings.profileEdit, style: AppTextStyles.bodySm(color: Colors.white, weight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(colors: [AppColors.accent, Color(0xFFE8942A)]),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 3),
                      ),
                      alignment: Alignment.center,
                      child: Text(p.initials, style: AppTextStyles.displayLg(color: Colors.white, weight: FontWeight.w800)),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(Icons.camera_alt, size: 12, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(p.name, style: AppTextStyles.displayLg(color: Colors.white)),
                      Text(p.phone, style: AppTextStyles.bodyMd(color: Colors.white.withValues(alpha: 0.7))),
                      Text(p.email, style: AppTextStyles.bodyMd(color: Colors.white.withValues(alpha: 0.7))),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  _Stat(v: '${p.ordersCount}', l: AppStrings.profileOrders),
                  Container(width: 1, height: 36, color: Colors.white24),
                  _Stat(v: p.savedAmount, l: AppStrings.profileSaved, highlight: true),
                  Container(width: 1, height: 36, color: Colors.white24),
                  _Stat(v: p.rating, l: AppStrings.profileRating),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.v, required this.l, this.highlight = false});
  final String v;
  final String l;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(v, style: AppTextStyles.displayLg(color: highlight ? AppColors.accent : Colors.white, weight: FontWeight.w800)),
          Text(l, style: AppTextStyles.bodySm(color: Colors.white.withValues(alpha: 0.7))),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.onTap,
    this.badge,
  });

  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final VoidCallback onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, size: 18, color: iconColor),
      ),
      title: Text(title, style: AppTextStyles.bodyMd(weight: FontWeight.w600)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (badge != null)
            Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(99)),
              child: Text(badge!, style: AppTextStyles.displayXs(color: Colors.white)),
            ),
          Icon(Icons.chevron_right, color: AppColors.onSurface3),
        ],
      ),
    );
  }
}
