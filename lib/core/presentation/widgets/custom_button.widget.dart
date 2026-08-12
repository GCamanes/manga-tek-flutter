import 'package:flutter/material.dart';
import 'package:mangatek_flutter/core/extensions/build_context.extensions.dart';

enum CustomButtonType { primary, secondary }

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = CustomButtonType.primary,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final CustomButtonType type;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final isPrimary = type == CustomButtonType.primary;

    final effectiveOnPressed = isLoading ? null : onPressed;

    final child = isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(
                isPrimary ? colors.onBackground : colors.primary,
              ),
            ),
          )
        : Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isPrimary ? colors.onBackground : colors.primary,
            ),
          );

    if (isPrimary) {
      return SizedBox(
        height: 56,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: effectiveOnPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.primary,
            disabledBackgroundColor: colors.primary.withValues(alpha: 0.6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: child,
        ),
      );
    }

    return SizedBox(
      height: 56,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: effectiveOnPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: colors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: child,
      ),
    );
  }
}
