import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../components/create_memo_dialog.dart';
import '../models/memo.dart';

class MemoListPage extends HookConsumerWidget {
  const MemoListPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      ref.read(memoProvider).fetchItems();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('yukimemo'),
      ),
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
                title: Text(memo.title),
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
