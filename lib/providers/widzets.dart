import 'package:flutter/cupertino.dart';
import 'package:should_have_bought_app/models/widzet.dart';

class Widzets with ChangeNotifier {
  final List<Widzet> _items = [
    Widzet("a", Text('a')),
    Widzet("b", Text('b')),
    Widzet("c", Text('c')),
    Widzet("d", Text('d')),
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
}
