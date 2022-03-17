import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yukimemo/models/memo.dart';
import 'common/app_info.dart' as app_info;
import 'screens/memo_edit.dart';
import 'screens/memo_list.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => MemoModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: app_info.init(),
        builder: (context, snapshot) {
          return MaterialApp(
            title: 'yukimemo ver' + app_info.version,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: '/list',
            routes: <String, WidgetBuilder>{
              '/list': (BuildContext context) => const MemoListPage(),
              '/edit': (BuildContext context) {
                final args = ModalRoute.of(context)!.settings.arguments;
                if (args is String) {
                  return MemoEditPage(
                    uuid: args,
                  );
                }
                return const MemoListPage();
              },
            },
          );
        });
  }
}
