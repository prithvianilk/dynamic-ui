import 'package:dynamic_ui/dynamic_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RootCardDao {
  final _supabase = Supabase.instance.client;

  Future<DynamicCard> getRootDynamicCardDefinition(String id) {
    return _supabase
        .from("root_cards")
        .select('root_definition')
        .eq('id', id)
        .single()
        .then((json) => json['root_definition'])
        .then((value) => DynamicCard.fromJson(value));
  }
}
