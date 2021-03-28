import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/providers/widzets.dart';

class ReorderListScreen extends StatefulWidget {
  @override
  _ReorderListScreenState createState() => _ReorderListScreenState();
}

class _ReorderListScreenState extends State<ReorderListScreen> {
  void reorderData(int oldindex, int newindex) {
    setState(() {
      if (newindex > oldindex) {
        newindex -= 1;
      }
      final items =
          Provider.of<Widzets>(context, listen: false).removeItem(oldindex);
      Provider.of<Widzets>(context, listen: false).insertItem(newindex, items);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ReorderableListView(
        header: Text(
          'This is Reorderable List',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        children: <Widget>[
          for (final item in Provider.of<Widzets>(context).items)
            Card(
              color: Colors.blueGrey,
              key: ValueKey(item),
              elevation: 2,
              child: ListTile(
                title: Text(item.name),
                leading: Icon(
                  Icons.work,
                  color: Colors.black,
                ),
              ),
            ),
        ],
        onReorder: reorderData,
      ),
    );
  }
}
