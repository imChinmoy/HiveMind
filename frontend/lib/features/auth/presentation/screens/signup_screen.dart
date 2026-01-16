import 'package:flutter/material.dart';
import 'package:frontend/config/routes/app_router.dart';
import 'package:frontend/config/themes/app_colors.dart';
import 'package:frontend/features/auth/presentation/widgets/button.dart';
import 'package:frontend/features/auth/presentation/widgets/social_button.dart';
import 'package:frontend/features/auth/presentation/widgets/custom_textfield.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  DateTime? selectedDob;
  bool isLoading = false;


  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email cannot be empty';
    final emailRegex =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
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

  String? _validateDob(String? value) {
    if (selectedDob == null) return 'Date of birth is required';
    final age = DateTime.now().year - selectedDob!.year;
    if (age < 13) return 'You must be at least 13 years old';
    return null;
  }


  void signup() {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    _validateDob(dobController.text);
    _validateEmail(emailController.text);
    _validateUsername(usernameController.text);
    _validatePassword(passwordController.text);
    context.go('/home');

    setState(() {
      isLoading = false;
    });
  }

  void loginWithGoogle() {

  }

  void loginWithGithub() {

  }


  Future<void> _pickDate() async {
    final now = DateTime.now();
    final initialDate = selectedDob ?? DateTime(now.year - 18);

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: now,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.dark(
            primary: AppColors.primary,
            onPrimary: Colors.white,
            surface: AppColors.cardBackground,
            onSurface: AppColors.textPrimary,
          ),
        ),
        child: child!,
      ),
    );

    if (picked != null) {
      setState(() {
        selectedDob = picked;
        dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                  hint: 'Email',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  hint: 'Username',
                  controller: usernameController,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  hint: 'Password',
                  controller: passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 16),

                GestureDetector(
                  onTap: _pickDate,
                  child: AbsorbPointer(
                    child: CustomTextField(
                      hint: 'Date of Birth',
                      controller: dobController,
                    ),
                  ),
                ),
                const SizedBox(height: 24),


                PrimaryButton(
                  text: 'Sign Up',
                  isLoading: isLoading,
                  onPressed: signup,
                ),
                const SizedBox(height: 16),


                Row(
                  children: [
                    Expanded(
                        child: Divider(
                            color: AppColors.textMuted.withOpacity(0.5))),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'OR',
                        style: TextStyle(color: AppColors.textMuted),
                      ),
                    ),
                    Expanded(
                        child: Divider(
                            color: AppColors.textMuted.withOpacity(0.5))),
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
                      "Already have an account? ",
                      style: TextStyle(color: AppColors.textMuted),
                    ),
                    GestureDetector(
                      onTap: () => context.go('/login'),
                      child: const Text(
                        'Login',
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
