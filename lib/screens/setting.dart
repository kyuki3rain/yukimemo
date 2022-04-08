import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yukimemo/models/setting.dart';

import 'package:url_launcher/url_launcher.dart';

class SettingPage extends HookConsumerWidget {
  const SettingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('yukimemo',
            style: TextStyle(fontSize: 32, color: Colors.white)),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            Card(
                child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              title: const Text("Font Size", style: TextStyle(fontSize: 24.0)),
              trailing: ToggleButtons(
                children: const <Widget>[
                  Text("S", style: TextStyle(fontSize: 12.0)),
                  Text("M", style: TextStyle(fontSize: 18.0)),
                  Text("L", style: TextStyle(fontSize: 24.0)),
                ],
                onPressed: (int index) {
                  ref.read(settingProvider).update(index);
                },
                isSelected: ref.watch(settingProvider).isSelected,
              ),
            )),
            Card(
                child: ListTile(
                    title: const Center(
                        child: Text("privacy policy",
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ))),
                    onTap: () {
                      launch('https://kyukimemo.web.app/terms_en.html');
                    })),
          ]),
    );
  }
}
