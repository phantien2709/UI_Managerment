import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:managerment/KanbanBoard/floating_widget.dart';
import 'package:managerment/KanbanBoard/header_widget.dart';
import 'package:managerment/KanbanBoard/item.dart';
import 'package:managerment/KanbanBoard/item_widget.dart';

class KanbanBoard extends StatefulWidget {
  final double tileHeight = 100;
  final double headerHeight = 80;
  final double tileWidth = 300;

  const KanbanBoard({super.key});

  @override
  State<KanbanBoard> createState() => _KanbanBoardState();
}

class _KanbanBoardState extends State<KanbanBoard> {
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
        onWillAcceptWithDetails: (DragTargetDetails<Item> details) {
      Item? data = details.data;
      return (board[listId]!.isEmpty ||
          data.id != board[listId]?[targetPosition].id);
    }, onAcceptWithDetails: (DragTargetDetails<Item> details) {
      Item data = details.data;
      setState(() {
        board[data.listId]!.remove(data);
        data.listId = listId;
        if (board[listId]!.length > targetPosition) {
          board[listId]!.insert(targetPosition + 1, data);
        } else {
          board[listId]!.add(data);
        }
      });
    }, builder:
            (BuildContext context, List<Item?> data, List<dynamic> rejectData) {
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
              if (item == null) {
                return Container();
              }
              return Opacity(
                opacity: 0.5,
                child: ItemWidget(item: item),
              );
            }).toList()
          ],
        );
      }
    });
  }

  buiderHeader(String listId) {
    Widget header = Container(
      height: widget.headerHeight,
      child: HeaderWidget(
        title: listId,
      ),
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
          onWillAcceptWithDetails: (DragTargetDetails<String> details) {
            String? incomingListId = details.data;
            return listId != incomingListId;
          },
          onAcceptWithDetails: (DragTargetDetails<String> details) {
            String incomingListId = details.data;
            setState(() {
              LinkedHashMap<String, List<Item>> reOrderBoard = LinkedHashMap();
              for (String key in board.keys) {
                if (key == incomingListId) {
                  reOrderBoard[listId] = board[listId]!;
                } else if (key == listId) {
                  reOrderBoard[incomingListId] = board[incomingListId]!;
                } else {
                  reOrderBoard[key] = board[key]!;
                }
              }
              board = reOrderBoard;
            });
          },
          builder: (BuildContext context, List<String?> data,
              List<dynamic> rejectData) {
            if (data.isEmpty) {
              return Container(
                height: widget.headerHeight,
                width: widget.tileWidth,
              );
            } else {
              return Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 3, color: Colors.blueAccent)),
                height: widget.headerHeight,
                width: widget.tileWidth,
              );
            }
          },
        ),
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
            buiderHeader(listId),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: [
                    Draggable<Item>(
                      data: items[index],
                      child: ItemWidget(
                        item: items[index],
                      ),
                      childWhenDragging: Opacity(
                        opacity: 0.2,
                        child: ItemWidget(
                          item: items[index],
                        ),
                      ),
                      feedback: Container(
                        height: widget.headerHeight,
                        width: widget.tileWidth,
                        child: FloatingWidget(
                          child: ItemWidget(item: items[index]),
                        ),
                      ),
                    ),
                    buildItemDragTarget(listId, index, widget.tileHeight)
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
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: board.keys.map((String key){
            return Container(
              width: widget.tileWidth,
              child: buildKanbanList(key, board[key]!),
            );
          }).toList()
        ),
      ),
    );
  }
}
