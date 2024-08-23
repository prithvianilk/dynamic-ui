import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: const MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

enum ChangeType { inc, dec }

class MyAppState extends ChangeNotifier {
  var x = 1;

  getNext(ChangeType type) {
    switch (type) {
      case ChangeType.inc:
        x++;
      case ChangeType.dec:
        x--;
    }

    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Column(
        children: [
          Text(appState.x.toString()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => appState.getNext(ChangeType.inc),
                child: const Text('+'),
              ),
              ElevatedButton(
                onPressed: () => appState.getNext(ChangeType.dec),
                child: const Text('-'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
