import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../utils/utils.dart';

class AuthService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> registerEmployee(
      String email, String password, BuildContext context) async {
    try {
      setIsLoading = true;
      if (email == '' || email == '') {
        throw ('All fields are required');
      }
      final AuthResponse response =
          await _supabase.auth.signUp(email: email, password: password);
      Utils.showSnackBar("Success ! you can now login", context,
          color: Colors.green);
      Navigator.pop(context);
      setIsLoading = false;
    } catch (e) {
      setIsLoading = false;
      Utils.showSnackBar(e.toString(), context, color: Colors.red);
    }
  }
}
