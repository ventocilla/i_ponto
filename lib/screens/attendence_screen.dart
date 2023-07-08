import 'package:flutter/material.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

// https://pub.dev/packages/slide_to_confirm

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  void confirmed() {
    //print('Slider confirmed!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 32),
              child: const Text(
                'Wellcome',
                style: TextStyle(color: Colors.black54, fontSize: 30),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Employee Name',
                style: TextStyle(fontSize: 25),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 32),
              child: const Text(
                "Today's status",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 32),
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(2, 2),
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Check In',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black54)),
                        SizedBox(width: 20),
                        Text('09:30', style: TextStyle(fontSize: 25)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Check Out',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black54)),
                        SizedBox(width: 20),
                        Text('--/--', style: TextStyle(fontSize: 25)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                '15 April 2023',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                '20:00:01 PM',
                style: TextStyle(fontSize: 15, color: Colors.black54),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 25),
              child: Builder(
                builder: (context) {
                  return ConfirmationSlider(
                    text: 'Slide to Check',
                    textStyle: const TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                    ),
                    onConfirmation: () => confirmed(),
                    foregroundColor: Colors.redAccent, // default: blueAccent
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
