import 'package:dynamic_ui/dynamic_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RootCardDao {
  final _supabase = Supabase.instance.client;

  Future<DynamicCard> getSingleDynamicCard() {
    return _supabase
        .from("root_cards")
        .select('root_definition')
        .single()
        .then((json) => json['root_definition'])
        .then((value) => DynamicCard.fromJson(value));
  }
}
