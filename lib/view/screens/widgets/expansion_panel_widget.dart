// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'item.dart';

class ExpansionPanelWidget extends StatefulWidget {
  List<Item> items;
  ExpansionPanelWidget({super.key, required this.items});

  @override
  State<ExpansionPanelWidget> createState() => _ExpansionPanelWidgetState();
}

class _ExpansionPanelWidgetState extends State<ExpansionPanelWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 9,
      margin: const EdgeInsets.only(left: 20, right: 20),
      padding: const EdgeInsets.all(5),
      child: ExpansionPanelList(
        dividerColor: Colors.black,
        expandedHeaderPadding: const EdgeInsets.all(5),
        animationDuration: const Duration(milliseconds: 1000),
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            widget.items[index].isExpanded = !isExpanded;
          });
        },
        children: widget.items
            .map(
              (e) => ExpansionPanel(
                canTapOnHeader: true,
                backgroundColor: Colors.white,
                // headers
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    title: Text(
                      e.headers,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[900],
                      ),
                    ),
                  );
                },
                // Body
                body: ListTile(
                  title: e.body,
                ),
                isExpanded: e.isExpanded,
                // value: e.headers,
              ),
            )
            .toList(),
      ),
    );
  }
}
