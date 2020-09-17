import 'package:flutter/widgets.dart';
import 'package:sembast/sembast.dart';

import 'db.dart';

class MyAppTheam extends ChangeNotifier {
  MyAppTheam._internal();
  static MyAppTheam _instance = MyAppTheam._internal();
  static MyAppTheam get instance => MyAppTheam._instance;

  final StoreRef _store = StoreRef.main();
  final Database _db = DB.instance.database;

  bool _darkEnabled = false;
  bool get darkEnabled => _darkEnabled;

  Future<void> init() async {
    this._darkEnabled =
        await this._store.record("DARK_ENABLED").get(this._db) ?? false;
  }

  change(bool darkEnable) async {
    this._darkEnabled = darkEnable;
    final dataSave = await this
        ._store
        .record("DARK_ENABLED")
        .put(this._db, this._darkEnabled);
    print("theme save: $dataSave");
    notifyListeners();
  }
}
