import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yukimemo/models/memo.dart';

class CreateMemoDialog extends ConsumerStatefulWidget {
  const CreateMemoDialog({Key? key}) : super(key: key);

  // createState()　で"State"（Stateを継承したクラス）を返す
  @override
  _CreateMemoDialogState createState() => _CreateMemoDialogState();
}

class _CreateMemoDialogState extends ConsumerState<CreateMemoDialog> {
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
          TextButton(
              child: const Text('追加'),
              onPressed: () {
                ref.read(memoProvider).add(_dataTextController.text, "").then(
                    (uuid) => {
                          Navigator.of(context)
                              .pushReplacementNamed('/edit', arguments: uuid)
                        });
              }),
        ]);
  }
}
