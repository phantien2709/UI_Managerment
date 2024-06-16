import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:managerment/AddNewTask/add_new_task.dart';
import 'package:managerment/ProjectPage/progress_cart.dart';
class TaskPage extends StatefulWidget {
  const TaskPage({
    Key? key,
    required this.Goback,
  }) : super(key: key);
  final void Function(int) Goback;
  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  DateTime _selectedDate = DateTime.now();
  void _onDateChange(DateTime date) {
    this.setState(() {
      this._selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Color.fromRGBO(242, 244, 255, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          widget.Goback(1);
                        },
                        child: Icon(
                          CupertinoIcons.arrow_left_square,
                          color: Colors.black,
                          size: 40,
                        ),
                      ),
                      Icon(
                        CupertinoIcons.search_circle,
                        color: Colors.black,
                        size: 40,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${DateFormat('MMM, d').format(this._selectedDate)}',
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddNewTask()));
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 123, 0, 245),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                CupertinoIcons.add_circled,
                                color: Colors.white,
                                size:20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Add task',
                                style: GoogleFonts.montserrat(
                                   color: Colors.white,
                                   fontSize: 15,
                                   fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  DatePicker(
                    height: 88,
                    width: 70,
                    DateTime.now(),
                    initialSelectedDate: this._selectedDate,
                    selectionColor: Color.fromARGB(255, 123, 0, 245),
                    onDateChange: this._onDateChange,
                    dateTextStyle: GoogleFonts.montserrat(fontSize: 23),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Task',
                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        ProgressCart(
                          projectName: "Project", 
                          completedPercent: 30,
                        ),
                        ProgressCart(
                          projectName: "Project", 
                          completedPercent: 30,
                        ),
                        ProgressCart(
                          projectName: "Project", 
                          completedPercent: 30,
                        ),
                        ProgressCart(
                          projectName: "Project", 
                          completedPercent: 30,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
