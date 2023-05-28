import 'package:auto_router_test/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late IucRouter iucRouter;
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    authProvider = AuthProvider();
    iucRouter = IucRouter(authProvider);

    authProvider.initAuthProvider();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => authProvider,
        ),
      ],
      child: MaterialApp.router(
        routerConfig: iucRouter.config(reevaluateListenable: authProvider),
        builder: (context, child) => Consumer<AuthProvider>(
          builder: (context, value, c) {
            final authState = value.authenticationState;
            final isLoading = value.isLoading ||
                authState == AuthenticationState.authenticating;

            return Stack(
              // duration: const Duration(seconds: 1),
              fit: StackFit.expand,
              children: [
                child!,
                if (isLoading)
                  Container(
                    color: Colors.white,
                    child: const SizedBox.expand(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
