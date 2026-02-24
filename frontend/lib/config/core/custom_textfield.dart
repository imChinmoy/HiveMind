import 'package:flutter/material.dart';
import 'package:frontend/config/themes/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.hint,
    this.obscureText = false,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  bool? _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      focusNode: _focusNode,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w500,
      ),
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: AppColors.textMuted.withOpacity(0.6),
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: AppColors.cardBackground,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.textMuted.withOpacity(0.3),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.textMuted.withOpacity(0.7),
                ),
                onPressed: _toggleVisibility,
              )
            : null,
      ),
    );
  }
}
