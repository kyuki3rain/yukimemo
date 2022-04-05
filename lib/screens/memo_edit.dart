import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yukimemo/models/setting.dart';
import '../models/memo.dart';

class MemoEditPage extends ConsumerStatefulWidget {
  const MemoEditPage({
    Key? key,
    required this.uuid,
  }) : super(key: key);

  final String uuid;

  // createState()　で"State"（Stateを継承したクラス）を返す
  @override
  _MemoEditPageState createState() => _MemoEditPageState();
}

class _MemoEditPageState extends ConsumerState<MemoEditPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Memo memo = ref.read(memoProvider).getMemo(widget.uuid);
    _titleController.text = memo.title;
    _contentController.text = memo.content;
  }

  @override
  Widget build(BuildContext context) {
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
              style: ref.watch(settingProvider).getTitleFont(),
            ),
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
              style: ref.watch(settingProvider).getBodyFont(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final Memo memo = Memo(
                widget.uuid, _titleController.text, _contentController.text);
            ref.read(memoProvider).update(memo);
            Navigator.pop(context);
          },
          tooltip: '保存',
          child: const Icon(Icons.save),
        ));
  }
}
