import 'package:flutter/material.dart';
import 'package:mangatek_flutter/core/extensions/build_context.extensions.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key, this.size = 32});

  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        valueColor: AlwaysStoppedAnimation<Color>(colors.secondary),
      ),
    );
  }
}
