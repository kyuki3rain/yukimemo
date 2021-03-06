import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yukimemo/auth_controller.dart';

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
  final Reader _read;
  final users = FirebaseFirestore.instance.collection('users');
  DateTime listUpdated = DateTime.now();

  MemoModel(this._read);

  int get length => _listItems.length;

  Future<void> fetchItems() async {
    // if (listUpdated.difference(DateTime.now()).inSeconds < 5) return;

    print("firestore use fetch.");
    User? user = _read(authControllerProvider);
    final memos = users.doc(user?.uid).collection('memos');
    final docs = await memos.get();
    final _listItems = docs.docs.map((doc) => Memo.doc(doc)).toList();
    this._listItems = _listItems;
    listUpdated = DateTime.now();
    notifyListeners();
  }

  Memo getMemo(String uuid) {
    return _listItems.firstWhere((item) => item.uuid == uuid);
  }

  Memo getMemoWithIndex(int index) {
    return _listItems[index];
  }

  Future<String> add(String title, String content) async {
    print("firestore use add.");
    User? user = _read(authControllerProvider);
    final memos = users.doc(user!.uid).collection('memos');
    DocumentReference value =
        await memos.add({'title': title, 'content': content});
    DocumentSnapshot doc = await value.get();
    _listItems.add(Memo.doc(doc));
    notifyListeners();

    return doc.id;
  }

  void remove(Memo memo) {
    print("firestore use remove.");
    User? user = _read(authControllerProvider);
    final memos = users.doc(user!.uid).collection('memos');
    memos.doc(memo.uuid).delete();
    int index = _listItems.indexWhere((element) => element.uuid == memo.uuid);
    _listItems.removeAt(index);
    notifyListeners();
  }

  void update(Memo memo) {
    print("firestore use update.");
    User? user = _read(authControllerProvider);
    final memos = users.doc(user!.uid).collection('memos');
    memos.doc(memo.uuid).set({'title': memo.title, 'content': memo.content});
    int index = _listItems.indexWhere((element) => element.uuid == memo.uuid);
    _listItems[index] = memo;
    notifyListeners();
  }
}

final memoProvider = ChangeNotifierProvider((ref) => MemoModel(ref.read));
