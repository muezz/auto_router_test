import 'package:auto_route/auto_route.dart';
import 'package:auto_router_test/auth_provider.dart';
import 'package:auto_router_test/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, c) {
      final isLoggedIn = authProvider.isAuthenticated;
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Login Screen'),
              Text(
                'isAuthenticated: $isLoggedIn',
                style: TextStyle(
                  color: isLoggedIn ? Colors.green : Colors.red,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await authProvider.signIn('', '');
                  if (context.mounted) {
                    context.router
                      ..popUntilRoot()
                      ..push(const HomeRoute());
                  }
                },
                child: const Text('Log In'),
              ),
            ],
          ),
        ),
      );
    });
  }
}
