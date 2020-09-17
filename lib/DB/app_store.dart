import 'package:sembast/sembast.dart';
import 'package:sembast_demo/DB/db.dart';
import 'package:sembast_demo/user_Model.dart';

class AppStore {
  AppStore._internal();
  static AppStore _instance = AppStore._internal();
  static AppStore get instance => AppStore._instance;

  final Database _db = DB.instance.database;
  final StoreRef<String, Map> _store = StoreRef<String, Map>("users");

  Future<List<User>> find() async {
    List<RecordSnapshot<String, Map>> snapshots =
        await this._store.find(this._db);

    return snapshots
        .map((RecordSnapshot<String, Map> snap) => User.fromJson(snap.value))
        .toList();
  }

  Future<void> add(User user) async {
    await this._store.record(user.id).put(this._db, user.toJson());
  }

  Future<int> delete({Finder finder}) async {
    return await this._store.delete(this._db, finder: finder);
  }
}
