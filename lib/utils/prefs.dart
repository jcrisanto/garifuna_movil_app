import 'package:shared_preferences/shared_preferences.dart';

class Prefs {

  static const SPEECH = 'speech';
  static const SEARCH = 'search';
  
  Prefs._();

  static Prefs getInstance() {
    return Prefs._();
  }

  SharedPreferences prefs;

  Future<void> setValue(String k, String v) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString(k, v);
  }

  Future<String> getValue(String k) async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString(k);
  }

}
