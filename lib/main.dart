import 'package:dynamic_ui/root_card_dao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dynamic_card.dart';
import 'logger.dart';

Future<void> main() async {
  await Supabase.initialize(
      url: const String.fromEnvironment("SUPABASE_URL"),
      anonKey: const String.fromEnvironment("SUPABASE_KEY"));

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
  var root = DynamicCard.loadingCard();

  State() {
    RootCardDao().getSingleDynamicCard().then((dynamicCard) {
      log("fetching card:");
      root = dynamicCard;
      notifyListeners();
    });
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.watch<State>();

    return Material(
      child: state.root.build(),
    );
  }
}
