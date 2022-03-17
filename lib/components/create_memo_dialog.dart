import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yukimemo/models/memo.dart';

class CreateMemoDialog extends StatefulWidget {
  const CreateMemoDialog({Key? key}) : super(key: key);

  // createState()　で"State"（Stateを継承したクラス）を返す
  @override
  _CreateMemoDialogState createState() => _CreateMemoDialogState();
}

class _CreateMemoDialogState extends State<CreateMemoDialog> {
  final TextEditingController _dataTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text(
          'Please enter a title.',
        ),
        content: TextField(
          controller: _dataTextController,
          decoration: const InputDecoration(
            hintText: 'Title',
          ),
          autofocus: true,
        ),
        actions: <Widget>[
          TextButton(
              child: const Text('キャンセル'),
              onPressed: () {
                Navigator.pop(context);
              }),
          Consumer<MemoModel>(builder: (context, memoData, _) {
            return TextButton(
                child: const Text('追加'),
                onPressed: () {
                  var memo = Memo(_dataTextController.text, "");
                  var index = memoData.add(memo);
                  Navigator.of(context).pushNamed('/edit', arguments: index);
                });
          }),
        ]);
  }
}
