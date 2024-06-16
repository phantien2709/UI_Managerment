import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:managerment/AddNewTask/categories_card.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({Key? key}) : super(key: key);

  @override
  State<AddNewTask> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddNewTask> {
  late TextEditingController titleController;
  late TextEditingController dateController;
  late TextEditingController startTime;
  late TextEditingController endTime;

  DateTime SelectedDate = DateTime.now();
  String Category = 'Mettings';

  @override
  void initState() {
    super.initState();
    titleController = new TextEditingController();
    dateController = new TextEditingController(
        text: '${DateFormat('EEE,MMM d, ' 'yy').format(this.SelectedDate)}');
    startTime = new TextEditingController(
        text: '${DateFormat.jm().format(DateTime.now())}');
    endTime = new TextEditingController(
        text:
            '${DateFormat.jm().format(DateTime.now().add(Duration(hours: 1)))}');
  }

  _selectedDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: this.SelectedDate,
        firstDate: DateTime(2005),
        lastDate: DateTime(2030));
    if (selected != null && selected != SelectedDate) {
      setState(() {
        SelectedDate = selected;
        dateController.text =
            '${DateFormat('EEE,MMM d, ' 'yy').format(selected)}';
      });
    }
  }

  _selectedTime(BuildContext context, String timeType) async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        if (timeType == 'StartTime') {
          startTime.text = result.format(context);
        } else if (timeType == 'EndTime') {
          endTime.text = result.format(context);
        }
      });
    }
  }

  _setCategory(String Category) {
    this.setState(() {
      this.Category = Category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          color: Color.fromRGBO(130, 0, 255, 1),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(CupertinoIcons.arrow_left_square,
                            size: 40, color: Colors.white),
                      ),
                      SizedBox(
                        width: 70,
                      ),
                      Text(
                        'Add New Task',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 25,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  child: TextFormField(
                    controller: titleController,
                    cursorColor: Colors.white,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                        labelText: 'Title',
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.white,
                        labelStyle: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  child: TextFormField(
                    controller: dateController,
                    cursorColor: Colors.white,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Date',
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _selectedDate(context);
                        },
                        child: Icon(
                          CupertinoIcons.calendar,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      fillColor: Colors.white,
                      labelStyle: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: TextField(
                                readOnly: true,
                                controller: startTime,
                                decoration: InputDecoration(
                                  labelText: "Date",
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      _selectedTime(context, 'StartTime');
                                    },
                                    child: Icon(
                                      CupertinoIcons.alarm,
                                      size: 30,
                                      color: Colors.black45,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black45),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black45),
                                  ),
                                  fillColor: Colors.black45,
                                  labelStyle: GoogleFonts.montserrat(
                                    color: Colors.black87,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextField(
                                  readOnly: true,
                                  controller: endTime,
                                  decoration: InputDecoration(
                                    labelText: 'Date',
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        _selectedTime(context, "EndTime");
                                      },
                                      child: Icon(
                                        CupertinoIcons.alarm,
                                        color: Colors.black45,
                                      ),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black45),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black45),
                                    ),
                                    fillColor: Colors.black45,
                                    labelStyle: GoogleFonts.montserrat(
                                      color: Colors.black87,
                                      fontSize: 22,
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 3,
                          cursorColor: Colors.black45,
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          decoration: InputDecoration(
                            labelText: "Description",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black26),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black26),
                            ),
                            fillColor: Colors.black45,
                            labelStyle: GoogleFonts.montserrat(
                              color: Colors.black87,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 12, bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Category",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: 20,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold),
                            ),
                            Wrap(
                              alignment: WrapAlignment.spaceEvenly,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    this.Category =
                                        this._setCategory("Meeting");
                                  },
                                  child: CategoriesCard(
                                    categoryText: 'Meeting',
                                    isActive: this.Category == 'Meeting',
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    this.Category =
                                        this._setCategory("Marketting");
                                  },
                                  child: CategoriesCard(
                                    categoryText: 'Marketting',
                                    isActive: this.Category == 'Marketting',
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    this.Category =
                                        this._setCategory("Study");
                                  },
                                  child: CategoriesCard(
                                    categoryText: 'Study',
                                    isActive: this.Category == 'Study',
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    this.Category =
                                        this._setCategory("Sports");
                                  },
                                  child: CategoriesCard(
                                    categoryText: 'Sports',
                                    isActive: this.Category == 'Sports',
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    this.Category =
                                        this._setCategory("Development");
                                  },
                                  child: CategoriesCard(
                                    categoryText: 'Development',
                                    isActive: this.Category == 'Development',
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    this.Category =
                                        this._setCategory("Dating");
                                  },
                                  child: CategoriesCard(
                                    categoryText: 'Dating',
                                    isActive: this.Category == 'Dating',
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    this.Category =
                                        this._setCategory("Urgent");
                                  },
                                  child: CategoriesCard(
                                    categoryText: 'Urgent',
                                    isActive: this.Category == 'Urgent',
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 100,),
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromRGBO(130, 0, 255, 1),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Create Task',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
