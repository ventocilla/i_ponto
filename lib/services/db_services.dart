import 'dart:math';

import 'package:i_ponto/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DbService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;

  String generateramdomEmployeeId() {
    final ramdom = Random();
    const allChars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final randomString =
        List.generate(8, (index) => allChars[ramdom.nextInt(allChars.length)])
            .join();
    return randomString;
  }

  Future insertNewUser(String email, var id) async {
    await _supabase.from(Constants.departmentTable).insert({
      'id': id,
      'name': '',
      'email': email,
      'employee_id': generateramdomEmployeeId(),
      'department': null,
    });
  }
}
