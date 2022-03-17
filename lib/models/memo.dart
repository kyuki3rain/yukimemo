import 'package:flutter/material.dart';

class Memo {
  final String title;
  final String content;

  Memo(this.title, this.content);
}

class MemoModel extends ChangeNotifier {
  final List<Memo> _listItems = [];

  int get length => _listItems.length;

  Memo memo(int index) {
    return _listItems[index];
  }

  int add(Memo memo) {
    _listItems.add(memo);
    notifyListeners();

    return _listItems.length - 1;
  }

  void remove(int index) {
    _listItems.removeAt(index);
    notifyListeners();
  }

  void update(int index, Memo memo) {
    _listItems[index] = memo;
    notifyListeners();
  }
}
