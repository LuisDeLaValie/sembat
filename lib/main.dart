import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sembast_demo/DB/app_theam.dart';
import 'package:sembast_demo/DB/db.dart';
import 'package:sembast_demo/screen/home_viw.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.instance.init();
  await MyAppTheam.instance.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    DB.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: MyAppTheam.instance,
      child: Consumer<MyAppTheam>(builder: (_, myAppthem, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: MyAppTheam.instance.darkEnabled
              ? ThemeData.dark()
              : ThemeData.light(),
          home: Homeview(),
        );
      }),
    );
  }
}
