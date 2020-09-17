import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast_demo/DB/app_store.dart';
import 'package:sembast_demo/DB/app_theam.dart';
import 'package:sembast_demo/user_Model.dart';

class Homeview extends StatefulWidget {
  @override
  _HomeviewState createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  List<User> _users = new List<User>();
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _loade();
  }

  _add() {
    final us = User.fake();
    AppStore.instance.add(us);
    this._users.add(us);
    setState(() {});
  }

  _loade() async {
    this._users = await AppStore.instance.find();
    setState(() {});
  }

  _delete() async {
    final Finder finder = new Finder(filter: Filter.greaterThan('age', 55));
    final Finder finder = new Finder(filter: Filter.matches('name', '^Ms.'));

    final count = await AppStore.instance.delete(finder: finder);
    final SnackBar bar =
        new SnackBar(content: Text("$count elementos eliminados"));
    _scaffoldkey.currentState.showSnackBar(bar);
    this._loade();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        actions: [
          Switch(
            value: MyAppTheam.instance.darkEnabled,
            onChanged: (bool das) {
              MyAppTheam.instance.change(das);
            },
          )
        ],
      ),
      body: ListView.builder(
          itemBuilder: (_, i) {
            final user = this._users[i];
            return ListTile(
              title: Text("${user.name}"),
              subtitle: Text("age ${user.age} email ${user.email}"),
            );
          },
          itemCount: this._users.length),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              this._delete();
            },
            heroTag: "clear",
            child: Icon(
              Icons.clear_all,
              color: Colors.white,
            ),
            backgroundColor: Colors.redAccent,
          ),
          SizedBox(
            width: 15,
          ),
          FloatingActionButton(
            onPressed: () {
              this._add();
            },
            heroTag: "add",
            child: Icon(Icons.person_add, color: Colors.white),
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
