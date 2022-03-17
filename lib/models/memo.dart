import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';

class Memo {
  late String uuid;
  late String title;
  late String content;

  Memo.doc(DocumentSnapshot doc) {
    uuid = doc.id;
    title = doc['title'];
    content = doc['content'];
  }

  Memo(this.uuid, this.title, this.content);
}

class MemoModel extends ChangeNotifier {
  late List<Memo> _listItems = [];
  final memos = FirebaseFirestore.instance.collection('memos');

  int get length => _listItems.length;

  Future<void> fetchItems() async {
    final docs = await memos.get();
    final _listItems = docs.docs.map((doc) => Memo.doc(doc)).toList();
    this._listItems = _listItems;
    notifyListeners();
  }

  Memo getMemo(String uuid) {
    return _listItems.firstWhere((item) => item.uuid == uuid);
  }

  Memo getMemoWithIndex(int index) {
    return _listItems[index];
  }

  Future<String> add(String title, String content) async {
    DocumentReference value =
        await memos.add({'title': title, 'content': content});
    DocumentSnapshot doc = await value.get();
    _listItems.add(Memo.doc(doc));
    notifyListeners();

    return doc.id;
  }

  void remove(Memo memo) {
    memos.doc(memo.uuid).delete();
    int index = _listItems.indexWhere((element) => element.uuid == memo.uuid);
    _listItems.removeAt(index);
    notifyListeners();
  }

  void update(Memo memo) {
    memos.doc(memo.uuid).set({'title': memo.title, 'content': memo.content});
    int index = _listItems.indexWhere((element) => element.uuid == memo.uuid);
    _listItems[index] = memo;
    notifyListeners();
  }
}
