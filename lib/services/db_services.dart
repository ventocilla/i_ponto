import 'dart:math';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../constants/constants.dart';
import '../models/department_model.dart';
import '../models/user_model.dart';
import '../utils/utils.dart';

class DbService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  UserModel? userModel;
  List<DepartmentModel> allDepartments = [];
  int? employeeDepartment;

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

  /*
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
  */

  Future<UserModel> getUserData() async {
    print('ID: ${_supabase.auth.currentUser!.id}');

    ///*
    final userData = await _supabase
        .from(Constants.employeeTable)
        .select()
        //.eq('íd', _supabase.auth.currentUser!.id)
        //.eq('name', "Leo Vento")
        .single();
    //*/
    //final userData = {'id': '10379f59-e5b0-46a2-bcd4-8adb9a9934b3'};
    //print('userData: $userData');
    userModel = UserModel.fromJson(userData);
    //print('UserModel: ${userModel}');

    // Since this function can be called muliple times, then it will reset the department value
    // Tha is why we are using condition to assigyn only at the fisrt time
    employeeDepartment == null
        ? employeeDepartment = userModel?.department
        : null;
    return userModel!;
  }

  Future<void> getAllDepartments() async {
    final List result =
        await _supabase.from(Constants.departmentTable).select();

    allDepartments = result
        .map((department) => DepartmentModel.fromJson(department))
        .toList();
    print('Result: $result');
    print('All Departments: $allDepartments');
    notifyListeners();
  }

  Future updateProfile(String name, BuildContext context) async {
    await _supabase.from(Constants.employeeTable).update({
      'name': name,
      'department': employeeDepartment,
    }).eq('id', _supabase.auth.currentUser!.id);

    if (context.mounted) {
      Utils.showSnackBar(
        'Profile updated succesfully',
        context,
        color: Colors.green,
      );
      notifyListeners();
    }
  }

  // @ 2:41
}
