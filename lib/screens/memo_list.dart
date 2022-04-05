import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../components/create_memo_dialog.dart';
import '../models/memo.dart';
import '../models/setting.dart';

class MemoListPage extends HookConsumerWidget {
  const MemoListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      ref.read(memoProvider).fetchItems();
      ref.read(settingProvider).fetchItems();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
          title: const Text('yukimemo',
              style: TextStyle(fontSize: 28, color: Colors.white)),
          actions: [
            IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context).pushNamed('/setting');
                })
          ]),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(memoProvider).fetchItems();
        },
        child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: ref.watch(memoProvider).length,
            itemBuilder: (context, index) {
              Memo memo = ref.watch(memoProvider).getMemoWithIndex(index);
              return Card(
                  child: ListTile(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/edit', arguments: memo.uuid);
                },
                title: Text(memo.title,
                    style: ref.watch(settingProvider).getLabelFont()),
                trailing: IconButton(
                    icon: const Icon(Icons.delete_forever),
                    onPressed: () {
                      ref.read(memoProvider).remove(memo);
                    }),
              ));
            }),
      ),
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
