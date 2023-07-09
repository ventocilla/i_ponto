import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_month_year_picker/simple_month_year_picker.dart';

import '../services/attendance_services.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final attendanceService = Provider.of<AttendanceService>(context);
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 20, top: 60, bottom: 10),
          child: const Text(
            "My Attendance",
            style: TextStyle(fontSize: 25),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(attendanceService.attendanceHistoryMonth,
                style: const TextStyle(fontSize: 25)),
            OutlinedButton(
                onPressed: () async {
                  final selectedDate =
                      await SimpleMonthYearPicker.showMonthYearPickerDialog(
                          context: context, disableFuture: true);
                  String pickedMonth =
                      DateFormat('MMMM yyyy').format(selectedDate);
                  attendanceService.attendanceHistoryMonth = pickedMonth;
                },
                child: const Text('Pick a month')),
          ],
        ),
        Expanded(
            child: FutureBuilder(
          future: attendanceService.getAttendanceHistory(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                // ..
              } else {
                return const Center(
                  child: Text(
                    'No data available',
                    style: TextStyle(fontSize: 25),
                  ),
                );
              }
            }
            return const LinearProgressIndicator(
              backgroundColor: Colors.white,
              color: Colors.grey,
            );
          },
        ))
      ],
    );
  }
}
