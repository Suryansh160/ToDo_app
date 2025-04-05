import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/datePicker.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    DateTime date;

    TextEditingController _titleController = TextEditingController();
    TextEditingController _descriptionController = TextEditingController();

    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Task Details',
              style: GoogleFonts.cabin(
                fontWeight: FontWeight.w400,
                fontSize: screenHeight * 0.03,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
            child: TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'New to-do title',
                filled: true,
                fillColor: Color.fromARGB(255, 230, 240, 243),
                floatingLabelStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 243, 169, 146),
                  ),
                ),

                // floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
          ),
          Container(
            // height: screenHeight * 0.9,
            padding: EdgeInsets.only(
              left: screenWidth * 0.03,
              right: screenWidth * 0.03,
              top: screenHeight * 0.02,
            ),
            child: TextFormField(
              controller: _descriptionController,

              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.05,
                  horizontal: screenWidth * 0.03,
                ),
                labelText: 'Description',
                filled: true,
                fillColor: Color.fromARGB(255, 230, 240, 243),
                floatingLabelStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 243, 169, 146),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.02),
          Datepicker(
            onDateSelected: (selectedDate) {
              date = selectedDate;
              print(date);
              print(_titleController.text);
              print(_descriptionController.text);
            },
          ),
        ],
      ),
    );
  }
}
