import 'package:kata/drawer_content.dart';
import 'package:kata/graphvis/graph_test.dart';

import 'package:kata/home_page.dart';
import 'package:kata/pgp/sign/attest_view.dart';
import 'package:kata/pgp/sign/import_cert_options.dart';
import 'package:kata/pgp/sign/import_cert_view.dart';
import 'package:kata/pgp/sign/sign_data.dart';
import 'package:kata/pgp/sign/sign_verify_dialog.dart';
import 'package:kata/pgp/sign/verify_view.dart';
import 'package:kata/pgp/wot/cert_list.dart';
import 'package:kata/pgp/wot/cert_list_args.dart';
import 'package:kata/pgp/cert/generate_key.dart';
import 'package:kata/pgp/pgp_view.dart';
import 'package:kata/pgp/wot/graph_controller.dart';
import 'package:kata/pgp/wot/sign_key_view.dart';
import 'package:kata/pgp/wot/trust_path_view.dart';
import 'package:kata/pgp_app_bar.dart';
import 'package:kata/prefs/my_cards.dart';
import 'package:kata/src/rust/api/pgp/cert.dart';
import 'package:flutter/material.dart';
import 'package:kata/src/rust/frb_generated.dart';
import 'package:go_router/go_router.dart';

Future<void> main() async {
  await RustLib.init();
  runApp(MyApp());
}

String titleFromPath(String path) {
  return switch (path) {
    '/' => 'My Cards',
    '/generate' => 'Generate identity',
    '/sign_data' => 'Full network',
    '/network' => 'Full network',
    '/sign' => 'Add trust signature',
    '/list' => 'All identities',
    '/share' => 'Sharing identity card',
    '/mycards' => 'My Cards',
    _ => 'Kata',
  };
}

class _MyAppState extends State<MyApp> {
  String title = 'My Cards';
  static final _routeObserver = RouteObserver<Route>();

  static final router = PgpView(
    child: MaterialApp.router(
      routerConfig: GoRouter(
        observers: [_routeObserver],
        routes: [
          ShellRoute(
            builder: (context, state, child) => Scaffold(
              appBar: PgpAppBar(
                title: titleFromPath(state.topRoute?.path ?? "/"),
              ),

              floatingActionButton: FloatingActionButton(
                onPressed: () async => await showDialog(
                  context: context,
                  builder: (ctx) => SignVerifyDialog(context: context),
                ),
                child: const Icon(Icons.new_label),
              ),
              drawer: Drawer(child: DrawerContent()),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.map_outlined),
                    label: 'Network Overview',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.perm_identity_sharp),
                    label: 'My Cards',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list),
                    label: 'All Cards',
                  ),
                ],
                currentIndex: switch (GoRouterState.of(
                  context,
                ).uri.toString()) {
                  '/network' => 0,
                  '/list' => 2,
                  _ => 1,
                },
                onTap: (value) {
                  context.go(switch (value) {
                    0 => '/network',
                    2 => '/list',
                    _ => '/',
                  });
                },
              ),
              body: child,
            ),
            routes: [
              GoRoute(path: '/', builder: (context, state) => HomePage()),
              GoRoute(
                path: '/network',
                builder: (context, state) => Center(child: GraphTest()),
              ),
              GoRoute(
                path: '/generate',
                builder: (context, state) => GenerateKey(),
              ),
              GoRoute(
                path: '/sign_data',
                builder: (context, state) => SignData(),
              ),
              GoRoute(
                path: '/sign',
                builder: (context, state) =>
                    SignKeyView(target: (state.extra as PgpCertWithIds?)!),
              ),
              GoRoute(
                path: '/list',
                builder: (context, state) {
                  final CertListArgs? args = state.extra as CertListArgs?;
                  return CertList(args: args ?? const CertListArgs());
                },
              ),
              GoRoute(
                path: '/import',
                builder: (context, state) {
                  final ImportCertOptions options =
                      state.extra as ImportCertOptions;
                  return ImportCertView(options: options);
                },
              ),
              GoRoute(
                path: '/share',
                builder: (context, state) {
                  return AttestView();
                },
              ),
              GoRoute(
                path: '/path',
                builder: (context, state) =>
                    TrustPathView(adapter: state.extra as GraphController),
              ),
              GoRoute(path: '/mycards', builder: (context, state) => MyCards()),
              GoRoute(path: '/scan', builder: (context, state) => VerifyView()),
            ],
          ),
        ],
      ),
      debugShowCheckedModeBanner: false,
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
