import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<IconData> navigationIcons = [
    FontAwesomeIcons.solidCalendarDays,
    FontAwesomeIcons.check,
    FontAwesomeIcons.solidUser,
  ];

  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Home Screen'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            for (int i = 0; i < navigationIcons.length; i++) ...{
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  setState(() {
                    currentIndex = i;
                  });
                },
                child: Center(
                  child: FaIcon(
                    navigationIcons[i],
                    color: i == currentIndex ? Colors.red : Colors.grey,
                    size: i == currentIndex ? 30 : 26,
                  ),
                ),
              ))
            }
          ],
        ),
      ),
    );
  }
}
