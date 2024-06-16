import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:managerment/ChatPage/chat_page.dart';
import 'package:managerment/ProjectPage/project_page.dart';
import 'package:managerment/TaskPage/task_page.dart';

class HomePage extends StatefulWidget {
  final String username;
  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onIndexChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      ProjectPage(username: widget.username),
      TaskPage(Goback: (int index) {
        print(index);
      }),
      //ChatPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      floatingActionButton: ClipOval(
        child: Container(
          width: 85,  // Increase the width
          height: 85,  // Increase the height
          child: FloatingActionButton(
            onPressed: () {
              // Handle floating button press action
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.purple,
                  width: 2,  // Increase the border width
                )
              ),
              child: Icon(
                Icons.person,
                size: 36,  // Increase the icon size if necessary
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 2,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.home_rounded,
                color: _selectedIndex == 0 ? Colors.purple : Colors.grey.shade800,
              ),
              onPressed: () => _onIndexChange(0),
            ),
            IconButton(
              icon: Icon(
                Icons.calendar_month_rounded,
                color: _selectedIndex == 1 ? Colors.purple : Colors.grey.shade800,
              ),
              onPressed: () => _onIndexChange(1),
            ),
            SizedBox(width: 40),
            IconButton(
              icon: Icon(
                CupertinoIcons.chat_bubble_2,
                color: _selectedIndex == 2 ? Colors.purple : Colors.grey.shade800,
              ),
              onPressed: () => _onIndexChange(2),
            ),
            IconButton(
              icon: Icon(
                Icons.search_rounded,
                color: _selectedIndex == 3 ? Colors.purple : Colors.grey.shade800,
              ),
              onPressed: () => _onIndexChange(3),
            ),
          ],
        ),
      ),
    );
  }
}
