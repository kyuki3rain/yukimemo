import 'package:flutter/material.dart';
import 'common/app_info.dart' as app_info;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await app_info.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'yukimemo ver' + app_info.version,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'yukimemo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, dynamic>> _listItems = [];
  final TextEditingController _dataTextController = TextEditingController();

  void _createMemo() {
    setState(() {
      _listItems.add({'text': _dataTextController.text});
    });
  }

  void _deleteMemo(int index) {
    setState(() {
      _listItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: _listItems.length,
          itemBuilder: (context, index) {
            return Card(
                child: ListTile(
              title: Text(_listItems[index]['text']),
              trailing: IconButton(
                  icon: const Icon(Icons.delete_forever),
                  onPressed: () {
                    _deleteMemo(index);
                  }),
            ));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (_) {
            _dataTextController.clear();
            return AlertDialog(
                title: const Text(
                  'Please enter a title.',
                ),
                content: TextField(
                  controller: _dataTextController,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                  ),
                  autofocus: true,
                ),
                actions: <Widget>[
                  TextButton(
                      child: const Text('キャンセル'),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  TextButton(
                      child: const Text('追加'),
                      onPressed: () {
                        _createMemo();
                        Navigator.pop(context);
                      }),
                ]);
          },
        ),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
