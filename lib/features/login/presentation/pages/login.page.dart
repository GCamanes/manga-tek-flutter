import 'package:flutter/material.dart';
import 'package:mangatek_flutter/core/extensions/build_context.extensions.dart';
import 'package:mangatek_flutter/core/navigation/router.helper.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => RouterHelper.goToHome(context),
          child: Text(context.trad.login),
        ),
      ),
    );
  }
}
