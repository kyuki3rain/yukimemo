import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/create_memo_dialog.dart';
import '../models/memo.dart';

class MemoListPage extends StatelessWidget {
  const MemoListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Consumer<MemoModel>(builder: (context, memoData, _) {
        return ListView.builder(
            itemCount: memoData.length,
            itemBuilder: (context, index) {
              return Card(
                  child: ListTile(
                title: Text(memoData.memo(index).title),
                trailing: IconButton(
                    icon: const Icon(Icons.delete_forever),
                    onPressed: () {
                      memoData.remove(index);
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
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
