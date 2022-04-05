import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yukimemo/models/setting.dart';

class SettingPage extends HookConsumerWidget {
  const SettingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).textTheme;

    useEffect(() {
      ref.read(settingProvider).fetchItems();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
          title: const Text('yukimemo',
              style: TextStyle(fontSize: 32, color: Colors.white)),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              })),
      body: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            Card(
                child: ListTile(
              title: const Text("Font Size"),
              trailing: ToggleButtons(
                children: const <Widget>[
                  Text("small", style: TextStyle(fontSize: 12.0)),
                  Text("medium", style: TextStyle(fontSize: 18.0)),
                  Text("large", style: TextStyle(fontSize: 24.0)),
                ],
                onPressed: (int index) {
                  ref.read(settingProvider).update(index);
                },
                isSelected: ref.watch(settingProvider).isSelected,
              ),
            )),
          ]),
    );
  }
}
