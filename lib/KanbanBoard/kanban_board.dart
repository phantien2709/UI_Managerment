import 'dart:collection';
import 'package:flutter/material.dart';

class Item {
  final String id;
  String listId;
  final String title;

  Item({required this.id, required this.listId, required this.title});
}

class KanbanBoard extends StatefulWidget {
  final double tileHeight = 100;
  final double headerHeight = 80;
  final double tileWidth = 300;

  @override
  _KanbanState createState() => _KanbanState();
}

class _KanbanState extends State<KanbanBoard> {
  LinkedHashMap<String, List<Item>> board = LinkedHashMap();

  @override
  void initState() {
    super.initState();
    board.addAll({
      "1": [
        Item(id: "1", listId: "1", title: "Pera"),
        Item(id: "2", listId: "1", title: "Papa"),
      ],
      "2": [
        Item(id: "3", listId: "2", title: "Auto"),
        Item(id: "4", listId: "2", title: "Bicicleta"),
        Item(id: "5", listId: "2", title: "Bla bla"),
      ],
      "3": [
        Item(id: "6", listId: "3", title: "Chile"),
        Item(id: "7", listId: "3", title: "Madagascar"),
        Item(id: "8", listId: "3", title: "Japón"),
      ],
    });
  }

  buildItemDragTarget(String listId, int targetPosition, double height) {
    return DragTarget<Item>(
      // ignore: deprecated_member_use
      onWillAccept: (Item? data) {
        return data != null && (board[listId]!.isEmpty || data.id != board[listId]?[targetPosition].id);
      },
      // ignore: deprecated_member_use
      onAccept: (Item data) {
        setState(() {
          board[data.listId]!.remove(data);
          data.listId = listId;
          if (board[listId]!.length > targetPosition) {
            board[listId]!.insert(targetPosition + 1, data);
          } else {
            board[listId]!.add(data);
          }
        });
      },
      builder: (BuildContext context, List<Item?> data, List<dynamic> rejectedData) {
        if (data.isEmpty) {
          return Container(
            height: height,
          );
        } else {
          return Column(
            children: [
              Container(
                height: height,
              ),
              ...data.map((Item? item) {
                if (item == null) return Container();
                return Opacity(
                  opacity: 0.5,
                  child: ItemWidget(item: item),
                );
              }).toList()
            ],
          );
        }
      },
    );
  }

  buildHeader(String listId) {
    Widget header = Container(
      height: widget.headerHeight,
      child: HeaderWidget(title: listId),
    );

    return Stack(
      children: [
        Draggable<String>(
          data: listId,
          child: header,
          childWhenDragging: Opacity(
            opacity: 0.2,
            child: header,
          ),
          feedback: FloatingWidget(
            child: Container(
              width: widget.tileWidth,
              child: header,
            ),
          ),
        ),
        buildItemDragTarget(listId, 0, widget.headerHeight),
        DragTarget<String>(
          onWillAccept: (String? incomingListId) {
            return listId != incomingListId;
          },
          onAccept: (String incomingListId) {
            setState(
              () {
                LinkedHashMap<String, List<Item>> reorderedBoard = LinkedHashMap();
                for (String key in board.keys) {
                  if (key == incomingListId) {
                    reorderedBoard[listId] = board[listId]!;
                  } else if (key == listId) {
                    reorderedBoard[incomingListId] = board[incomingListId]!;
                  } else {
                    reorderedBoard[key] = board[key]!;
                  }
                }
                board = reorderedBoard;
              },
            );
          },
          builder: (BuildContext context, List<String?> data, List<dynamic> rejectedData) {
            if (data.isEmpty) {
              return Container(
                height: widget.headerHeight,
                width: widget.tileWidth,
              );
            } else {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    color: Colors.blueAccent,
                  ),
                ),
                height: widget.headerHeight,
                width: widget.tileWidth,
              );
            }
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    buildKanbanList(String listId, List<Item> items) {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            buildHeader(listId),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: [
                    Draggable<Item>(
                      data: items[index],
                      child: ItemWidget(item: items[index]),
                      childWhenDragging: Opacity(
                        opacity: 0.2,
                        child: ItemWidget(item: items[index]),
                      ),
                      feedback: Container(
                        height: widget.tileHeight,
                        width: widget.tileWidth,
                        child: FloatingWidget(
                          child: ItemWidget(item: items[index]),
                        ),
                      ),
                    ),
                    buildItemDragTarget(listId, index, widget.tileHeight),
                  ],
                );
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(title: Text("Kanban test")),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: board.keys.map((String key) {
            return Container(
              width: widget.tileWidth,
              child: buildKanbanList(key, board[key]!),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  final String title;

  const HeaderWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.teal,
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        trailing: Icon(
          Icons.sort,
          color: Colors.white,
          size: 30.0,
        ),
        onTap: () {},
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  final Item item;

  const ItemWidget({Key? key, required this.item}) : super(key: key);

  ListTile makeListTile(Item item) => ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        title: Text(
          item.title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        subtitle: Text("listId: ${item.listId}"),
        trailing: Icon(
          Icons.sort,
          color: Colors.white,
          size: 30.0,
        ),
        onTap: () {},
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(64, 75, 96, .9),
        ),
        child: makeListTile(item),
      ),
    );
  }
}

class FloatingWidget extends StatelessWidget {
  final Widget child;

  const FloatingWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
