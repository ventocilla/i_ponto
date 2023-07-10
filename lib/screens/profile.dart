import 'package:flutter/material.dart';
import 'package:i_ponto/services/db_services.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  int selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    final DbService dbservice = Provider.of<DbService>(context);
    return const Scaffold(
      body: Center(
        child: Text('Profile'),
      ),
    );
  }
}
