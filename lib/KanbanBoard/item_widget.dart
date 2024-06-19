import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:managerment/KanbanBoard/item.dart';

class ItemWidget extends StatelessWidget {
  final Item item;
  
  const ItemWidget({super.key, required this.item});

  ListTile makeListtitle(Item item) => ListTile(
    contentPadding: EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 10,
    ),
    title: Text(
      item.title,
      style: GoogleFonts.montserrat(
        color: Colors.white
      ),
    ),
    subtitle: Text('listId: ${item.listId}'),
    trailing: Icon(
      CupertinoIcons.sort_down,
      color: Colors.white,
      size: 30,
    ),
    onTap: (){},
  );
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(64, 75, 96, .9),
        ),
        child: makeListtitle(item),
      ),
    );
  }
}