import 'package:flutter/material.dart';
import 'package:frontend/config/routes/app_router.dart';
import 'package:frontend/config/themes/app_colors.dart';
import 'package:frontend/features/auth/presentation/widgets/button.dart';
import 'package:frontend/features/auth/presentation/widgets/social_button.dart';
import 'package:frontend/features/auth/presentation/widgets/custom_textfield.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void login() {
    setState(() {
      isLoading = true;
    });

  }

  void loginWithGoogle() {
    
  }

  void loginWithGithub() {
    
  }

  @override

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
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
                hint: 'Email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                hint: 'Password',
                controller: passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 24),

              PrimaryButton(
                text: 'Login',
                isLoading: isLoading,
                onPressed: login,
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: Divider(color: AppColors.textMuted.withOpacity(0.5)),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'OR',
                      style: TextStyle(color: AppColors.textMuted),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: AppColors.textMuted.withOpacity(0.5)),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              SocialButton(
                text: 'Continue with Google',
                assetPath: 'assets/images/google.png',
                onPressed: loginWithGoogle,
              ),
              const SizedBox(height: 12),
              SocialButton(
                text: 'Continue with GitHub',
                assetPath: 'assets/images/github.png',
                onPressed: loginWithGithub,
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
                    onTap: () => context.go('/signup'),
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
    );
  }
}
