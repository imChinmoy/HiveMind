import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/config/core/toast.dart';
import 'package:frontend/config/themes/app_colors.dart';
import 'package:frontend/features/auth/presentation/state/provider.dart';
import 'package:frontend/features/auth/presentation/widgets/button.dart';
import 'package:frontend/features/auth/presentation/widgets/social_button.dart';
import 'package:frontend/features/auth/presentation/widgets/custom_textfield.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) return 'Username cannot be empty';
    if (value.length < 3) return 'Username must be at least 3 characters';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password cannot be empty';
    if (value.length < 8) return 'Password must be at least 8 characters';
    final numberRegex = RegExp(r'\d');
    final letterRegex = RegExp(r'[A-Za-z]');
    if (!numberRegex.hasMatch(value) || !letterRegex.hasMatch(value)) {
      return 'Password must contain letters and numbers';
    }
    return null;
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    final notifier = ref.read(authNotifierProvider.notifier);
    await notifier.login(
      username: usernameController.text.trim(),
      password: passwordController.text.trim(),
    );

   
  }

  void _loginWithGoogle() {}

  void _loginWithGithub() {}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authState = ref.watch(authNotifierProvider);

     final state = ref.read(authNotifierProvider);

    if (state.user != null) {
      ToastHelper.showSuccess(context, 'Login Successful!');
      Navigator.of(context).pushReplacementNamed('/home');
    } else if (state.error != null) {
      ToastHelper.showError(context, state.error!);
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.08),

                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    text: 'Hive',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Hunters K-Pop',
                      color: AppColors.textPrimary,
                      letterSpacing: 3,
                    ),
                    children: [
                      TextSpan(
                        text: 'Mind',
                        style: TextStyle(color: AppColors.textPrimaryMuted),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Think together. One mind, many ideas.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Hunters K-Pop',
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: AppColors.textMuted,
                  ),
                ),
                SizedBox(height: size.height * 0.08),

                CustomTextField(
                  hint: 'Username',
                  controller: usernameController,
                  validator: _validateUsername,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  hint: 'Password',
                  controller: passwordController,
                  obscureText: true,
                  validator: _validatePassword,
                ),
                const SizedBox(height: 24),

                PrimaryButton(
                  text: 'Login',
                  isLoading: authState.isLoading,
                  onPressed: _login,
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppColors.textMuted.withOpacity(0.5),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'OR',
                        style: TextStyle(color: AppColors.textMuted),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: AppColors.textMuted.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                SocialButton(
                  text: 'Continue with Google',
                  assetPath: 'assets/images/google.png',
                  onPressed: _loginWithGoogle,
                ),
                const SizedBox(height: 12),
                SocialButton(
                  text: 'Continue with GitHub',
                  assetPath: 'assets/images/github.png',
                  onPressed: _loginWithGithub,
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(color: AppColors.textMuted),
                    ),
                    GestureDetector(
                      onTap: () => context.push('/signup'),
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
