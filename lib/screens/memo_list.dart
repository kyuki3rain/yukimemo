import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../components/create_memo_dialog.dart';
import '../models/memo.dart';

class MemoListPage extends ConsumerWidget {
  const MemoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('yukimemo'),
      ),
      body: FutureBuilder(
          future: ref.read(memoProvider).fetchItems(),
          builder: (context, snapshot) {
            return ListView.builder(
                itemCount: ref.watch(memoProvider).length,
                itemBuilder: (context, index) {
                  Memo memo = ref.watch(memoProvider).getMemoWithIndex(index);
                  return Card(
                      child: ListTile(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed('/edit', arguments: memo.uuid);
                    },
                    title: Text(memo.title),
                    trailing: IconButton(
                        icon: const Icon(Icons.delete_forever),
                        onPressed: () {
                          ref.read(memoProvider).remove(memo);
                        }),
                  ));
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (_) {
            return const CreateMemoDialog();
          },
        ),
        tooltip: 'メモを追加',
        child: const Icon(Icons.add),
      ),
    );
  }
}
