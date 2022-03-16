import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yukimemo/models/memo.dart';
import 'common/app_info.dart' as app_info;
import 'screens/memo_ilst.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
            home: const MemoListPage(title: 'yukimemo'),
          );
        });
  }
}
