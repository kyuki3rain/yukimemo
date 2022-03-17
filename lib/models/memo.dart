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

  void add(Memo memo) {
    _listItems.add(memo);
    notifyListeners();
  }

  void remove(int index) {
    _listItems.removeAt(index);
    notifyListeners();
  }

  void update(Memo memo) {
    var index = _listItems.indexWhere((element) => element.title == memo.title);
    _listItems[index] = memo;
    notifyListeners();
  }
}
