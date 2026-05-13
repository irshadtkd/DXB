import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_widgets.dart';
import '../../session/presentation/session_cubit.dart';

/// Mobile-first sign-in: email or phone, OTP step, autofill hints, validation.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _otp = TextEditingController();
  int _channel = 0;
  int _step = 0;

  @override
  void dispose() {
    _email.dispose();
    _phone.dispose();
    _otp.dispose();
    super.dispose();
  }

  bool _isValidEmail(String v) {
    final t = v.trim();
    return t.contains('@') && t.length > 5;
  }

  bool _isValidPhone(String v) {
    final digits = v.replaceAll(RegExp(r'\D'), '');
    return digits.length >= 9;
  }

  void _sendOtp() {
    final ok = _channel == 0 ? _isValidEmail(_email.text) : _isValidPhone(_phone.text);
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_channel == 0 ? AppStrings.loginInvalidEmail : AppStrings.loginInvalidPhone),
        ),
      );
      return;
    }
    setState(() => _step = 1);
    FocusScope.of(context).nextFocus();
  }

  Future<void> _verify() async {
    if (_otp.text.trim().length < 4) return;
    await context.read<SessionCubit>().loginSuccess();
    if (!mounted) return;
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && _step == 1) setState(() => _step = 0);
      },
      child: Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.loginTitle),
        automaticallyImplyLeading: false,
        leading: _step == 1
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () => setState(() => _step = 0),
              )
            : null,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: AutofillGroup(
            child: ListView(
              padding: EdgeInsets.fromLTRB(20, 8, 20, 16 + bottomInset),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                Text(AppStrings.loginSubtitle, style: AppTextStyles.dmSans(fontSize: 14, color: AppColors.textSecondary, height: 1.45)),
                const SizedBox(height: 20),
                SegmentedButton<int>(
                  segments: const [
                    ButtonSegment(value: 0, label: Text(AppStrings.loginEmailTab), icon: Icon(Icons.email_outlined, size: 18)),
                    ButtonSegment(value: 1, label: Text(AppStrings.loginPhoneTab), icon: Icon(Icons.phone_android_rounded, size: 18)),
                  ],
                  selected: {_channel},
                  onSelectionChanged: (s) {
                    setState(() {
                      _channel = s.first;
                      _step = 0;
                    });
                  },
                ),
                const SizedBox(height: 20),
                if (_step == 0) ...[
                  if (_channel == 0)
                    TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.email],
                      decoration: const InputDecoration(labelText: AppStrings.loginEmailHint),
                      validator: (v) => _isValidEmail(v ?? '') ? null : AppStrings.loginInvalidEmail,
                      onFieldSubmitted: (_) => _sendOtp(),
                    )
                  else ...[
                    Text(AppStrings.loginPhoneCountryHint, style: AppTextStyles.dmSans(fontSize: 12, color: AppColors.textMuted)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _phone,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.telephoneNumber],
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d+\s\-]'))],
                      decoration: const InputDecoration(labelText: AppStrings.loginPhoneHint, prefixIcon: Icon(Icons.phone_outlined)),
                      validator: (v) => _isValidPhone(v ?? '') ? null : AppStrings.loginInvalidPhone,
                      onFieldSubmitted: (_) => _sendOtp(),
                    ),
                  ],
                  const SizedBox(height: 24),
                  AppPrimaryButton(label: AppStrings.loginSendOtp, onPressed: _sendOtp),
                ] else ...[
                  Text(AppStrings.loginOtpHint, style: AppTextStyles.dmSans(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _otp,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    maxLength: 6,
                    autofillHints: const [AutofillHints.oneTimeCode],
                    decoration: const InputDecoration(counterText: ''),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onFieldSubmitted: (_) => _verify(),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(onPressed: _sendOtp, child: Text(AppStrings.loginResendOtp)),
                  ),
                  const SizedBox(height: 16),
                  AppPrimaryButton(label: AppStrings.loginVerifyOtp, onPressed: _verify),
                ],
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () => context.push('/register/business'),
                    child: Text.rich(
                      TextSpan(
                        text: AppStrings.loginNoAccount,
                        style: AppTextStyles.dmSans(color: AppColors.textSecondary),
                        children: [
                          TextSpan(text: AppStrings.loginRegister, style: AppTextStyles.dmSans(fontWeight: FontWeight.w700, color: AppColors.primary)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ), // Scaffold
    ); // PopScope
  }
}
