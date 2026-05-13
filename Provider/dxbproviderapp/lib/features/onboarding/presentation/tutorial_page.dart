import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_widgets.dart';
import '../../session/presentation/session_cubit.dart';

class _TutorialSlide {
  const _TutorialSlide({required this.icon, required this.title, required this.body});
  final IconData icon;
  final String title;
  final String body;
}

class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key});

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  final _controller = PageController();
  int _index = 0;

  static const List<_TutorialSlide> _slides = [
    _TutorialSlide(icon: Icons.receipt_long_rounded, title: AppStrings.tutorialSlide1Title, body: AppStrings.tutorialSlide1Body),
    _TutorialSlide(icon: Icons.category_rounded, title: AppStrings.tutorialSlide2Title, body: AppStrings.tutorialSlide2Body),
    _TutorialSlide(icon: Icons.account_balance_wallet_rounded, title: AppStrings.tutorialSlide3Title, body: AppStrings.tutorialSlide3Body),
    _TutorialSlide(icon: Icons.forum_rounded, title: AppStrings.tutorialSlide4Title, body: AppStrings.tutorialSlide4Body),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    await context.read<SessionCubit>().completeTutorial();
    if (!mounted) return;
    context.go('/login');
  }

  void _next() {
    if (_index < _slides.length - 1) {
      _controller.nextPage(duration: const Duration(milliseconds: 320), curve: Curves.easeOutCubic);
    } else {
      _finish();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _finish,
                child: Text(AppStrings.tutorialSkip, style: AppTextStyles.dmSans(fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _slides.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (context, i) {
                  final slide = _slides[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(slide.icon, size: 56, color: AppColors.primary),
                        ),
                        const SizedBox(height: 32),
                        Text(slide.title, textAlign: TextAlign.center, style: AppTextStyles.sora(fontSize: 22, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 16),
                        Text(slide.body, textAlign: TextAlign.center, style: AppTextStyles.dmSans(fontSize: 15, color: AppColors.textSecondary, height: 1.5)),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _slides.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: i == _index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: i == _index ? AppColors.primary : AppColors.border,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: AppPrimaryButton(
                label: _index == _slides.length - 1 ? AppStrings.tutorialGetStarted : AppStrings.tutorialNext,
                onPressed: _next,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
