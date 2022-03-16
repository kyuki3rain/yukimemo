import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/memo.dart';

class MemoEditPage extends StatefulWidget {
  const MemoEditPage({Key? key, required this.memo}) : super(key: key);

  final Memo memo;

  // createState()　で"State"（Stateを継承したクラス）を返す
  @override
  _MemoEditPageState createState() => _MemoEditPageState();
}

class _MemoEditPageState extends State<MemoEditPage> {
  late TextEditingController _dataTextController;

  @override
  void initState() {
    super.initState();
    _dataTextController = TextEditingController(text: widget.memo.content);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MemoModel>(builder: (context, memoData, _) {
      return Scaffold(
        body: ListView(
          children: <Widget>[
            TextField(
                controller: _dataTextController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'メモを入力',
                  contentPadding: EdgeInsets.all(20.0),
                ),
                maxLines: 10000,
                style: const TextStyle(fontSize: 20.0)),
          ],
        ),
        floatingActionButton:
            Consumer<MemoModel>(builder: (context, memoData, _) {
          return FloatingActionButton.extended(
            onPressed: () {
              final Memo memo =
                  Memo(widget.memo.title, _dataTextController.text);
              memoData.update(memo);
              Navigator.pushNamedAndRemoveUntil(context, '/list', (_) => false);
            },
            label: const Text(
              '保存',
            ),
          );
        }),
      );
    });
  }
}
