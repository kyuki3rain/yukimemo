import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'screens/memo_edit.dart';
import 'screens/memo_list.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'yukimemo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/list',
      routes: <String, WidgetBuilder>{
        '/list': (BuildContext context) => const MemoListPage(),
        '/edit': (BuildContext context) {
          final args = ModalRoute.of(context)?.settings.arguments;

          if (args is String) {
            return MemoEditPage(
              uuid: args,
            );
          }
          return const MemoListPage();
        },
      },
    );
  }
}
