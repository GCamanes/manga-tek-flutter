import 'package:flutter/material.dart';
import 'package:mangatek_flutter/core/extensions/build_context.extensions.dart';
import 'package:mangatek_flutter/core/navigation/router.helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.trad.home,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => RouterHelper.goToLogin(context),
              child: Text(context.trad.logout),
            ),
          ],
        ),
      ),
    );
  }
}
