import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dynamic_card.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => State(),
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}

class State extends ChangeNotifier {
  var root = DynamicCardBuilder()
      .setCards([
        DynamicCardBuilder().setContent("1").setPadding(60).build(),
        DynamicCardBuilder().setContent("2").build(),
      ])
      .setPadding(2)
      .build();

  getNext() {}
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.watch<State>();

    return state.root.build();
  }
}
