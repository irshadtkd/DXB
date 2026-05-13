import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_messenger.dart';
import '../../../core/widgets/app_widgets.dart';
import 'settings_cubits.dart';

Widget _kv(String k, dynamic v) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 120, child: Text(k, style: AppTextStyles.dmSans(fontSize: 12, color: AppColors.textMuted))),
          Expanded(child: Text('$v', style: AppTextStyles.dmSans(fontWeight: FontWeight.w600))),
        ],
      ),
    );

class BusinessProfilePage extends StatelessWidget {
  const BusinessProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<BusinessProfileCubit>()..load(),
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.businessProfileTitle)),
        body: BlocConsumer<BusinessProfileCubit, SettingsMapState>(
          listener: (c, s) {
            if (s is SettingsMapFailure) showAppErrorBanner(c, s.failure.message);
          },
          builder: (c, s) {
            if (s is SettingsMapLoading || s is SettingsMapInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (s is SettingsMapFailure) {
              return AppEmptyState(title: AppStrings.errorTitle, subtitle: s.failure.message, onRetry: () => c.read<BusinessProfileCubit>().load());
            }
            final data = (s as SettingsMapLoaded).data;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: data.entries.map((e) => _kv(e.key, e.value)).toList(),
            );
          },
        ),
      ),
    );
  }
}

class ServiceAreasPage extends StatelessWidget {
  const ServiceAreasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ServiceAreasCubit>()..load(),
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.serviceAreasTitle)),
        body: BlocConsumer<ServiceAreasCubit, SettingsMapState>(
          listener: (c, s) {
            if (s is SettingsMapFailure) showAppErrorBanner(c, s.failure.message);
          },
          builder: (c, s) {
            if (s is SettingsMapLoading || s is SettingsMapInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (s is SettingsMapFailure) {
              return AppEmptyState(title: AppStrings.errorTitle, subtitle: s.failure.message, onRetry: () => c.read<ServiceAreasCubit>().load());
            }
            final data = (s as SettingsMapLoaded).data;
            final areas = (data['areas'] as List<dynamic>?) ?? [];
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(AppStrings.mapAreasHint, style: AppTextStyles.dmSans(color: AppColors.textSecondary)),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(AppAssets.mapPlaceholder, height: 160, width: double.infinity, fit: BoxFit.cover),
                ),
                const SizedBox(height: 12),
                ...areas.map((a) => ListTile(title: Text('$a'), trailing: const Icon(Icons.map_outlined))),
              ],
            );
          },
        ),
      ),
    );
  }
}

class OperatingHoursPage extends StatelessWidget {
  const OperatingHoursPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<OperatingHoursCubit>()..load(),
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.operatingHoursTitle)),
        body: BlocConsumer<OperatingHoursCubit, SettingsMapState>(
          listener: (c, s) {
            if (s is SettingsMapFailure) showAppErrorBanner(c, s.failure.message);
          },
          builder: (c, s) {
            if (s is SettingsMapLoading || s is SettingsMapInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (s is SettingsMapFailure) {
              return AppEmptyState(title: AppStrings.errorTitle, subtitle: s.failure.message, onRetry: () => c.read<OperatingHoursCubit>().load());
            }
            final slots = ((s as SettingsMapLoaded).data['slots'] as List<dynamic>?) ?? [];
            return ListView.builder(
              itemCount: slots.length,
              itemBuilder: (c, i) {
                final m = slots[i] as Map<String, dynamic>;
                return ListTile(
                  title: Text(m['day'] as String? ?? ''),
                  subtitle: Text(AppStrings.timeRange('${m['open']}', '${m['close']}')),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class TeamRolesPage extends StatelessWidget {
  const TeamRolesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TeamRolesCubit>()..load(),
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.teamRolesTitle)),
        body: BlocConsumer<TeamRolesCubit, SettingsMapState>(
          listener: (c, s) {
            if (s is SettingsMapFailure) showAppErrorBanner(c, s.failure.message);
          },
          builder: (c, s) {
            if (s is SettingsMapLoading || s is SettingsMapInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (s is SettingsMapFailure) {
              return AppEmptyState(title: AppStrings.errorTitle, subtitle: s.failure.message, onRetry: () => c.read<TeamRolesCubit>().load());
            }
            final members = ((s as SettingsMapLoaded).data['members'] as List<dynamic>?) ?? [];
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: members.length,
              itemBuilder: (c, i) {
                final m = members[i] as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: AppCard(
                    child: ListTile(
                      title: Text(m['name'] as String? ?? ''),
                      subtitle: Text('${m['role']}${AppStrings.labelSeparator}${m['permissions']}', style: AppTextStyles.dmSans(fontSize: 12, color: AppColors.textSecondary)),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class NotificationPrefsPage extends StatelessWidget {
  const NotificationPrefsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NotificationPrefsCubit>()..load(),
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.notificationPrefsTitle)),
        body: BlocConsumer<NotificationPrefsCubit, SettingsMapState>(
          listener: (c, s) {
            if (s is SettingsMapFailure) showAppErrorBanner(c, s.failure.message);
          },
          builder: (c, s) {
            if (s is SettingsMapLoading || s is SettingsMapInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (s is SettingsMapFailure) {
              return AppEmptyState(title: AppStrings.errorTitle, subtitle: s.failure.message, onRetry: () => c.read<NotificationPrefsCubit>().load());
            }
            final data = (s as SettingsMapLoaded).data;
            return ListView(
              children: data.entries.map((e) {
                return SwitchListTile(
                  title: Text(e.key, style: AppTextStyles.dmSans(fontWeight: FontWeight.w600)),
                  value: e.value == true,
                  onChanged: (_) {},
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HelpCenterCubit>()..load(),
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.helpCenterTitle)),
        body: BlocConsumer<HelpCenterCubit, SettingsMapState>(
          listener: (c, s) {
            if (s is SettingsMapFailure) showAppErrorBanner(c, s.failure.message);
          },
          builder: (c, s) {
            if (s is SettingsMapLoading || s is SettingsMapInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (s is SettingsMapFailure) {
              return AppEmptyState(title: AppStrings.errorTitle, subtitle: s.failure.message, onRetry: () => c.read<HelpCenterCubit>().load());
            }
            final topics = ((s as SettingsMapLoaded).data['topics'] as List<dynamic>?) ?? [];
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ...topics.map((e) {
                  final m = e as Map<String, dynamic>;
                  return AppCard(
                    child: ExpansionTile(
                      title: Text(m['title'] as String? ?? ''),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(m['body'] as String? ?? '', style: AppTextStyles.dmSans(height: 1.5)),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 12),
                AppPrimaryButton(label: AppStrings.chatSupport, onPressed: () {}),
                AppOutlineButton(label: AppStrings.callSupport, onPressed: () {}),
              ],
            );
          },
        ),
      ),
    );
  }
}

class WebToolsPage extends StatelessWidget {
  const WebToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<WebToolsCubit>()..load(),
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.webToolsTitle)),
        body: BlocConsumer<WebToolsCubit, SettingsMapState>(
          listener: (c, s) {
            if (s is SettingsMapFailure) showAppErrorBanner(c, s.failure.message);
          },
          builder: (c, s) {
            if (s is SettingsMapLoading || s is SettingsMapInitial) {
              return ListView.builder(itemCount: 5, itemBuilder: (_, __) => const ShimmerListTile());
            }
            if (s is SettingsMapFailure) {
              return AppEmptyState(title: AppStrings.errorTitle, subtitle: s.failure.message, onRetry: () => c.read<WebToolsCubit>().load());
            }
            final feats = ((s as SettingsMapLoaded).data['features'] as List<dynamic>?) ?? [];
            return LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth >= 900;
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: wide ? 2 : 1,
                    mainAxisExtent: 130,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: feats.length,
                  itemBuilder: (c, i) {
                    final f = feats[i] as Map<String, dynamic>;
                    return AppCard(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(f['title'] as String? ?? '', style: AppTextStyles.sora(fontWeight: FontWeight.w700)),
                            const SizedBox(height: 6),
                            Expanded(child: Text(f['description'] as String? ?? '', style: AppTextStyles.dmSans(fontSize: 12, color: AppColors.textSecondary))),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
