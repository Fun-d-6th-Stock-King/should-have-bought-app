import 'package:flutter/material.dart';
import 'package:should_have_bought_app/models/widzet.dart';

class Widzets with ChangeNotifier {
  final List<Widzet> _items = [
    Widzet(
      "a",
      Card(
        child: ListTile(
          title: Text('This is Title "A"'),
          subtitle: Text('this Is subtitle'),
          leading: Icon(Icons.place),
          tileColor: Colors.red,
        ),
      ),
    ),
    Widzet(
      "b",
      Card(
        child: ListTile(
          title: Text('This is Title "B"'),
          subtitle: Text('this Is subtitle'),
          leading: Icon(Icons.place),
          tileColor: Colors.green,
        ),
      ),
    ),
    Widzet(
      "c",
      Card(
        child: ListTile(
          title: Text('This is Title "C"'),
          subtitle: Text('this Is subtitle'),
          leading: Icon(Icons.place),
          tileColor: Colors.yellow,
        ),
      ),
    ),
    Widzet(
      "d",
      Card(
        child: ListTile(
          title: Text('This is Title "D"'),
          subtitle: Text('this Is subtitle'),
          leading: Icon(Icons.place),
        ),
      ),
    ),
  ];
  List<Widzet> get items {
    return [..._items];
  }

  Widzet removeItem(int index) {
    final item = _items.removeAt(index);
    notifyListeners();
    return item;
  }

  void insertItem(int index, Widzet item) {
    _items.insert(index, item);
    notifyListeners();
  }

  void addItem(Widzet widzet) {
    _items.add(widzet);
    notifyListeners();
  }
}
