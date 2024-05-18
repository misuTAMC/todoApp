import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinhtoandidong_project/provider/time_provider.dart';

List selectableTimes = [
  "10",
  "300",
  "600",
  "900",
  "1200",
  "1500",
  "1800",
  "2100",
  "2400",
  "2700",
  "3000",
  "3300",
  "3600",
  "3900",
  "4200",
  "4500",
  "4800",
  "5100",
  "5400",
  "5700",
  "6000",
  "6300",
  "6600",
  "6900",
  "7200",
];



class TimeOptions extends StatelessWidget {
  TimeOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimeProvider>(context);
    return SingleChildScrollView(
      controller: ScrollController(initialScrollOffset: 155),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: selectableTimes.map((time) {
          return InkWell(
            onTap: () {
              return provider.selectTime(double.parse(time));
            },
            child: Container(
              margin: EdgeInsets.only(right: 10),
              width: 70,
              height: 50,
              decoration: int.parse(time) == provider.selectedTime
                  ? BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 2,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    )
                  : BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 1,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
              child: Center(
                child: Text(
                  '${int.parse(time) ~/ 60}',
                  style: TextStyle(
                    color: int.parse(time) == provider.selectedTime
                        ? Colors.black
                        : Colors.blueGrey,
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
