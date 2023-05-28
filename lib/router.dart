import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:auto_router_test/router.gr.dart';

import 'auth_provider.dart';

/// Run this whenever a change is made:
/// dart run build_runner build
@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class IucRouter extends $IucRouter implements AutoRouteGuard {
  final AuthProvider _authProvider;

  IucRouter(
    AuthProvider a,
  ) : _authProvider = a;

  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final authState = _authProvider.authenticationState;
    final isLoggedIn = authState == AuthenticationState.loggedIn;
    final isLoggedOut = authState == AuthenticationState.loggedOut;
    final goingToLogin = LoginRoute.page.name == resolver.route.name;

    log(authState.name);
    // This log should show up any time the user navigates OR the Auth Provider
    // notifies its listeners.
    log('Global Nav Guard was called');

    if (isLoggedIn || goingToLogin) {
      resolver.next();
    } else {
      push(const LoginRoute());
      resolver.next(false);
    }
  }

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: HomeRoute.page, initial: true),
      ];
}
