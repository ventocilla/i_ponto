import 'package:flutter/material.dart';
import 'package:i_ponto/screens/home_screen.dart';
import 'package:i_ponto/screens/login_screen.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

class SpalshScreen extends StatelessWidget {
  const SpalshScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    //authService.signOut();
    return authService.currentUser == null
        ? const LoginScreen()
        : const HomeScreen();
  }
}
