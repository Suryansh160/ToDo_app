import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../widgets/datePicker.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late DateTime date;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final CollectionReference _collection = FirebaseFirestore.instance.collection(
    "todos",
  );
  @override
  void initState() {
    super.initState();
    date = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    Future<void> uploadInDB() async {
      try {
        final id = const Uuid().v4();
        await _collection.doc(id).set({
          "title": _titleController.text.trim(),
          "description": _descriptionController.text.trim(),
          "date": Timestamp.fromDate(date),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task added successfully!')),
        );
        print(id);
      } on FirebaseException catch (error) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.toString())));
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
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
              child: Expanded(
                child: TextFormField(
                  maxLines: null,
                  controller: _descriptionController,
                  textAlignVertical: TextAlignVertical.top,
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
            ),

            SizedBox(height: screenHeight * 0.02),
            Datepicker(
              onDateSelected: (selectedDate) {
                setState(() {
                  date = selectedDate;
                });
                // print(date);
                // print(_titleController.text);
                // print(_descriptionController.text);
              },
            ),
            SizedBox(height: screenHeight * 0.05),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  uploadInDB();
                });
              },

              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.35,
                  vertical: screenHeight * 0.02,
                ),
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              child: Text(
                'Add',
                style: TextStyle(fontSize: screenHeight * 0.02),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
