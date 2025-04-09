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

  Future<void> _delete(String id) async {
    try {
      await FirebaseFirestore.instance.collection('todos').doc(id).delete();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Task removed')));
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Your Tasks',
              style: GoogleFonts.cabin(
                fontWeight: FontWeight.w400,
                fontSize: screenHeight * 0.03,
              ),
            ),
          ),
          Expanded(
            child:
                _tasks.isEmpty
                    ? (Image.asset('assets/image2.png'))
                    : ListView.builder(
                      itemBuilder: (context, index) {
                        final task = _tasks[index];
                        final DateTime realDate = task['date'].toDate();

                        return Dismissible(
                          key: Key(index.toString()),
                          direction: DismissDirection.startToEnd,
                          onDismissed:
                              (direction) => {
                                setState(_delete(task['id']) as VoidCallback),
                              },
                          child: Card(
                            color: Colors.deepOrange[70],
                            margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.1,
                              vertical: screenHeight * 0.01,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        DateFormat(
                                          'EEE, dd MMM',
                                        ).format(realDate),
                                        style: TextStyle(
                                          fontSize: screenHeight * 0.018,
                                          color: Colors.deepOrange,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ), // Space between texts
                                      Text(
                                        task['title'].toString(),
                                        textAlign: TextAlign.center,

                                        style: GoogleFonts.quicksand(
                                          fontSize: screenHeight * 0.023,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: screenWidth * 0.29),
                                    ],
                                  ),
                                ),

                                Text(task['description'].toString()),
                              ],
                            ),
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
