import 'dart:async';
import 'dart:developer';
import 'dart:math' as m;

import 'package:auto_router_test/user.dart';
import 'package:flutter/material.dart';

enum AuthenticationState {
  loggedIn,
  authenticating,
  loggedOut,
}

class AuthProvider with ChangeNotifier {
  // Variable to simulate the user object/model
  // If it is null, then the user is not logged in.
  UserModel? user;

  AuthenticationState authenticationState = AuthenticationState.loggedOut;

  bool isLoading = true;

  AuthProvider();

  void initAuthProvider() async {
    setLoading(true);
    // fetch current user from your auth provider
    final currentUser = await getUser();

    if (currentUser != null) {
      user = currentUser;
      authenticationState = AuthenticationState.loggedIn;
    } else {
      authenticationState = AuthenticationState.loggedOut;
    }

    setLoading(false);
  }

  void setLoading(bool b) {
    isLoading = b;
    notifyListeners();
  }

  Future<UserModel?> getUser() async {
    await Future.delayed(const Duration(seconds: 1));
    final random = m.Random();
    if (random.nextBool()) {
      return UserModel();
    } else {
      return null;
    }
  }

  bool get isAuthenticated {
    return user != null;
  }

  Future<void> signIn(String email, String password) async {
    setLoading(true);
    try {
      await Future.delayed(const Duration(seconds: 1));
      user = UserModel();
      authenticationState = AuthenticationState.loggedIn;
      setLoading(false);
    } catch (error) {
      setLoading(false);
      log("Error at signIn: $error");
    }
  }

  Future<void> signOut() async {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 1));
    user = null;
    authenticationState = AuthenticationState.loggedOut;
    setLoading(false);
  }
}
