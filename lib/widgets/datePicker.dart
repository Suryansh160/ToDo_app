import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class Datepicker extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const Datepicker({super.key, required this.onDateSelected});

  @override
  State<Datepicker> createState() => _DatepickerState();
}

class _DatepickerState extends State<Datepicker> {
  int selectedIndex = 0;
  final List<DateTime> days = List.generate(
    30,
    (index) => DateTime.now().add(Duration(days: index)),
  );
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: screenHeight * 0.13,
      child: ListView.builder(
        itemCount: days.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final date = days[index];
          final dayName = DateFormat('EEE').format(date);
          final dayNumber = date.day.toString();
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onDateSelected(date);
            },
            child: Container(
              width: screenWidth * 0.17,
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.012,
                vertical: screenHeight * 0.012,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    dayName.toUpperCase(),
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w400,
                      fontSize: screenHeight * 0.018,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.deepOrange : Colors.white,

                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.009,
                    ),
                    child: Text(
                      dayNumber,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: screenHeight * 0.023,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
