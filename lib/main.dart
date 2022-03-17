import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yukimemo/models/memo.dart';
import 'common/app_info.dart' as app_info;
import 'screens/memo_edit.dart';
import 'screens/memo_list.dart';

Future<void> main() async {
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
                if (args is int) {
                  return Consumer<MemoModel>(builder: (context, memoData, _) {
                    return MemoEditPage(
                      memo: memoData.memo(args),
                      index: args,
                    );
                  });
                }
                return const MemoListPage();
              },
            },
          );
        });
  }
}
