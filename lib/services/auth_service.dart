import 'package:flutter/material.dart';
import 'package:i_ponto/services/db_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../utils/utils.dart';

class AuthService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  final DbService _dbService = DbService();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /*
  Future<void> register(
      String email, String password, BuildContext context) async {
    try {
      setIsLoading = true;
      if (email == '' || email == '') {
        throw ('All fields are required');
      }
      var navigator = Navigator.of(context);
      final AuthResponse response =
          await _supabase.auth.signUp(email: email, password: password);
      navigator.pop(context);
      Utils.showSnackBar("Success ! you can now login", context,
          color: Colors.green);
      //Navigator.pop(context);
      setIsLoading = false;
    } catch (e) {
      setIsLoading = false;
      Utils.showSnackBar(e.toString(), context, color: Colors.red);
    }
  }
  */

  Future<void> registerEmployee(
      String email, String password, BuildContext context) async {
    try {
      setIsLoading = true;
      if (email == '' || email == '') {
        throw ('All fields are required');
      }
      final AuthResponse response =
          await _supabase.auth.signUp(email: email, password: password);
      if (response != null) {
        await _dbService.insertNewUser(email, response.user!.id);
        //
        Utils.showSnackBar("Successfully registered !", context,
            color: Colors.green);
        loginEmployee(email, password, context);
        Navigator.pop(context);
      }
    } catch (e) {
      setIsLoading = false;
      Utils.showSnackBar(e.toString(), context, color: Colors.red);
    }
  }

  Future<void> loginEmployee(
      String email, String password, BuildContext context) async {
    try {
      setIsLoading = true;
      if (email == '' || email == '') {
        throw ('All fields are required');
      }
      final AuthResponse response = await _supabase.auth
          .signInWithPassword(email: email, password: password);
      setIsLoading = false;
    } catch (e) {
      setIsLoading = false;
      Utils.showSnackBar(e.toString(), context, color: Colors.red);
    }
  }

  Future signOut() async {
    await _supabase.auth.signOut();
    notifyListeners();
  }

  User? get currentUser => _supabase.auth.currentUser;
}
