import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/ms_primary_button.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (i) => setState(() => _page = i),
                children: const [_OnboardFood(), _OnboardServices()],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
              child: Column(
                children: [
                  _Dots(page: _page),
                  const SizedBox(height: 20),
                  MsPrimaryButton(
                    label: _page == 0 ? AppStrings.obGetStarted : AppStrings.obContinue,
                    onPressed: () {
                      if (_page == 0) {
                        _controller.nextPage(duration: const Duration(milliseconds: 320), curve: Curves.easeOut);
                      } else {
                        context.go(RoutePaths.login);
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  if (_page == 0)
                    GestureDetector(
                      onTap: () => context.go(RoutePaths.login),
                      child: Text.rich(
                        TextSpan(
                          style: AppTextStyles.bodyMd(color: AppColors.onSurface3),
                          children: [
                            TextSpan(text: AppStrings.obAlreadyAccount),
                            TextSpan(
                              text: AppStrings.obSignIn,
                              style: AppTextStyles.bodyMd(color: AppColors.primary, weight: FontWeight.w600),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  else
                    GestureDetector(
                      onTap: () => context.go(RoutePaths.login),
                      child: Text(
                        AppStrings.obSkip,
                        style: AppTextStyles.bodyMd(color: AppColors.onSurface3),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.page});
  final int page;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(2, (i) {
        final active = i == page;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: active ? 24 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: active ? AppColors.primary : AppColors.outline,
            borderRadius: BorderRadius.circular(99),
          ),
        );
      }),
    );
  }
}

class _OnboardFood extends StatelessWidget {
  const _OnboardFood();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.accent, Color(0xFFE8942A)],
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(painter: _StripePainter()),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.15),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.25), width: 2),
                        ),
                        child: const Icon(Icons.restaurant, size: 90, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 30,
                  child: _Bubble(icon: Icons.timer, text: AppStrings.ob1Bubble1),
                ),
                Positioned(
                  bottom: 60,
                  right: 20,
                  child: _Bubble(icon: Icons.local_offer, text: AppStrings.ob1Bubble2, iconColor: AppColors.sage),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.ob1Title,
                  style: AppTextStyles.displayXl(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  AppStrings.ob1Body,
                  style: AppTextStyles.bodyLg(color: AppColors.onSurface3),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _OnboardServices extends StatelessWidget {
  const _OnboardServices();

  @override
  Widget build(BuildContext context) {
    final tiles = [
      (Icons.local_laundry_service, AppStrings.splashLaundry),
      (Icons.directions_car, 'Car Rental'),
      (Icons.handyman, 'Home Services'),
      (Icons.cleaning_services, 'Cleaning'),
    ];
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.splashGradientStart, AppColors.splashGradientMid, AppColors.splashGradientEnd],
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.15,
                  children: tiles
                      .map(
                        (t) => Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(t.$1, size: 36, color: AppColors.accent),
                              const SizedBox(height: 8),
                              Text(t.$2, style: AppTextStyles.bodySm(color: Colors.white, weight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.ob2Title,
                  style: AppTextStyles.displayXl(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  AppStrings.ob2Body,
                  style: AppTextStyles.bodyLg(color: AppColors.onSurface3),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.icon, required this.text, this.iconColor});
  final IconData icon;
  final String text;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x26000000), blurRadius: 20, offset: Offset(0, 4))],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: iconColor ?? AppColors.primary),
          const SizedBox(width: 8),
          Text(text, style: AppTextStyles.bodySm(weight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _StripePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = Colors.white.withValues(alpha: 0.08);
    const step = 20.0;
    for (double i = -size.height; i < size.width + size.height; i += step) {
      canvas.drawLine(Offset(i, 0), Offset(i + size.height, size.height), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
