import 'package:kata/observable_router.dart';
import 'package:kata/pgp/pgp_view.dart';
import 'package:flutter/material.dart';
import 'package:kata/src/rust/frb_generated.dart';

Future<void> main() async {
  await RustLib.init();
  runApp(MyApp());
}

class _MyAppState extends State<MyApp> {
  String title = 'My Cards';

  static final router = PgpView(
    child: Builder(
      builder: (context) => MaterialApp.router(
        routerConfig: observableRouter(context),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return router;
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();

  const MyApp({super.key});
}
