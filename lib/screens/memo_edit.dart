import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/memo.dart';

class MemoEditPage extends StatefulWidget {
  const MemoEditPage({
    Key? key,
    required this.memo,
    required this.index,
  }) : super(key: key);

  final Memo memo;
  final int index;

  // createState()　で"State"（Stateを継承したクラス）を返す
  @override
  _MemoEditPageState createState() => _MemoEditPageState();
}

class _MemoEditPageState extends State<MemoEditPage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.memo.title);
    _contentController = TextEditingController(text: widget.memo.content);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MemoModel>(builder: (context, memoData, _) {
      return Scaffold(
        body: ListView(
          children: <Widget>[
            TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'タイトルを入力',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                ),
                style: const TextStyle(fontSize: 20.0)),
            TextField(
              controller: _contentController,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintText: 'メモを入力',
                contentPadding: EdgeInsets.all(20.0),
              ),
              maxLines: null,
              minLines: 10,
              autofocus: true,
            ),
          ],
        ),
        floatingActionButton:
            Consumer<MemoModel>(builder: (context, memoData, _) {
          return FloatingActionButton(
            onPressed: () {
              final Memo memo =
                  Memo(_titleController.text, _contentController.text);
              memoData.update(widget.index, memo);
              Navigator.pushNamedAndRemoveUntil(context, '/list', (_) => false);
            },
            tooltip: '保存',
            child: const Icon(Icons.save),
          );
        }),
      );
    });
  }
}
