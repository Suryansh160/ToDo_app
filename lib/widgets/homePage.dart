import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  final CollectionReference _tasksCollection = FirebaseFirestore.instance
      .collection('todos');
  List<Map<String, dynamic>> _tasks = [];

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    try {
      QuerySnapshot snap = await _tasksCollection.get();

      setState(() {
        _tasks =
            snap.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
        print(_tasks[0]);
      });
    } on FirebaseException catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          Text('your tasks'),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final task = _tasks[index];
                final DateTime realDate = task['date'].toDate();

                return Card(
                  color: Colors.deepOrange[70],
                  margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1,
                    vertical: screenHeight * 0.01,
                  ),
                  child: Column(
                    children: [
                      Text(
                        task['title'].toString(),
                        style: GoogleFonts.quicksand(
                          fontSize: screenHeight * 0.023,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(task['description'].toString()),
                      Text(DateFormat('EEE, dd MMM').format(realDate)),
                    ],
                  ),
                );
              },
              itemCount: _tasks.length,
            ),
          ),
        ],
      ),
    );
  }
}
