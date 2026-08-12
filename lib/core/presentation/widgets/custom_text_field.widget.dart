import 'package:flutter/material.dart';
import 'package:mangatek_flutter/core/extensions/build_context.extensions.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.isEnabled = true,
    this.isObscure = false,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
  });

  final String label;
  final TextEditingController controller;
  final bool isEnabled;
  final bool isObscure;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscured;

  @override
  void initState() {
    super.initState();
    _obscured = widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final constants = context.constantsTheme;
    final radius = BorderRadius.circular(constants.cornerRound);

    return TextField(
      controller: widget.controller,
      enabled: widget.isEnabled,
      obscureText: _obscured,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      onSubmitted: widget.onSubmitted,
      style: TextStyle(color: colors.onSurface),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(color: colors.onSurfaceVariant),
        filled: true,
        fillColor: colors.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: colors.onSurfaceVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: colors.onSurfaceVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: colors.primary, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(
            color: colors.onSurfaceVariant.withValues(alpha: 0.4),
          ),
        ),
        suffixIcon: widget.isObscure
            ? IconButton(
                icon: Icon(
                  _obscured ? Icons.visibility_off : Icons.visibility,
                  color: colors.onSurfaceVariant,
                ),
                onPressed: () => setState(() => _obscured = !_obscured),
              )
            : null,
      ),
    );
  }
}
