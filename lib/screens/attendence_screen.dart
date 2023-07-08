import 'package:flutter/material.dart';
import 'package:i_ponto/models/user_model.dart';
import 'package:i_ponto/services/attendance_services.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

import '../services/db_services.dart';

// https://pub.dev/packages/slide_to_confirm

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  @override
  void initState() {
    Provider.of<AttendanceService>(context, listen: false).getTodayAttendance();
    super.initState();
  }

  void confirmed() {
    print('Slider confirmed!');
  }

  @override
  Widget build(BuildContext context) {
    final attendanceService = Provider.of<AttendanceService>(context);
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

            ///*
            Consumer<DbService>(builder: (context, dbServie, child) {
              return FutureBuilder(
                  future: dbServie.getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      UserModel user = snapshot.data!;

                      return Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          user.name != '' ? user.name : "#${user.employeeId}",
                          style: const TextStyle(fontSize: 25),
                        ),
                      );
                    } else {
                      print('No data');
                    }
                    return const SizedBox(
                      width: 60,
                      child: LinearProgressIndicator(),
                    );
                  });
            }),
            //*/
            /*
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Name",
                style: TextStyle(fontSize: 25),
              ),
            ),
            */
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Check In',
                          style: TextStyle(fontSize: 20, color: Colors.black54),
                        ),
                        const SizedBox(width: 20),
                        Text(
                            attendanceService.attendanceModel?.checkIn ??
                                '--/--',
                            style: const TextStyle(fontSize: 25)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Check Out',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black54)),
                        const SizedBox(width: 20),
                        Text(
                          attendanceService.attendanceModel?.checkOut ??
                              '--/--',
                          style: const TextStyle(fontSize: 25),
                        ),
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
                    text: attendanceService.attendanceModel?.checkIn == null
                        ? 'Slide to Check In '
                        : 'Slide to Check Out',
                    textStyle: const TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                    ),
                    onConfirmation: () async {
                      confirmed();
                      await attendanceService.markAttendance(context);
                    },
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
