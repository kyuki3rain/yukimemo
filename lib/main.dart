import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'auth_controller.dart';
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

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authControllerState = ref.watch(authControllerProvider);

    return authControllerState == null
        ? const Center(
            child: SpinKitRotatingCircle(
            color: Colors.white,
            size: 50.0,
          ))
        : MaterialApp(
            title: 'yukimemo',
            theme: ThemeData(
                primarySwatch: Colors.blue, fontFamily: "Noto Sans JP"),
            initialRoute: '/list',
            routes: <String, WidgetBuilder>{
              '/list': (BuildContext context) =>
                  MemoListPage(user: authControllerState),
              '/edit': (BuildContext context) {
                final args = ModalRoute.of(context)?.settings.arguments;

                if (args is String) {
                  return MemoEditPage(
                    uuid: args,
                    user: authControllerState,
                  );
                }
                return MemoListPage(user: authControllerState);
              },
            },
          );
  }
}
