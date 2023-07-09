import 'dart:math';

import 'package:i_ponto/constants/constants.dart';
import 'package:i_ponto/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DbService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  UserModel? userModel;

  String generateramdomEmployeeId() {
    final ramdom = Random();
    const allChars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final randomString =
        List.generate(8, (index) => allChars[ramdom.nextInt(allChars.length)])
            .join();
    return randomString;
  }

  Future insertNewUser(String email, var id) async {
    await _supabase.from(Constants.employeeTable).insert({
      'id': id,
      'name': '',
      'email': email,
      'employee_id': generateramdomEmployeeId(),
      'department': null,
    });
  }

  Future<UserModel> getUserData() async {
    print('ID: ${_supabase.auth.currentUser!.id}');
    final userData = await _supabase
        .from(Constants.employeeTable)
        .select()
        .eq('íd', _supabase.auth.currentUser!.id)
        .single();
    userModel = UserModel.fromJson(userData);
    print('UserModel: ${userModel!}');
    return userModel!;
  }
}
