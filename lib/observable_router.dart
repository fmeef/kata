import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kata/circle/circle_list.dart';
import 'package:kata/circle/circle_list_options.dart';
import 'package:kata/circle/create_app.dart';
import 'package:kata/circle/create_circle.dart';
import 'package:kata/drawer_content.dart';
import 'package:kata/global_route_observer.dart';
import 'package:kata/graphvis/graph_test.dart';
import 'package:kata/graphvis/trust_path_view.dart';
import 'package:kata/home_page.dart';
import 'package:kata/pgp/cert/generate_key.dart';
import 'package:kata/pgp/sign/attest_view.dart';
import 'package:kata/pgp/sign/import_cert_options.dart';
import 'package:kata/pgp/sign/import_cert_view.dart';
import 'package:kata/pgp/sign/sign_data.dart';
import 'package:kata/pgp/sign/verify_view.dart';
import 'package:kata/pgp/wot/cert_list.dart';
import 'package:kata/pgp/wot/cert_list_args.dart';
import 'package:kata/pgp/wot/graph_controller.dart';
import 'package:kata/pgp/wot/sign_key_view.dart';
import 'package:kata/pgp_app_bar.dart';
import 'package:kata/prefs/prefs.dart';
import 'package:kata/smart_fab.dart';
import 'package:kata/src/rust/api/pgp/cert.dart';
import 'package:kata/title_controller.dart';
import 'package:provider/provider.dart';

GoRouter observableRouter(BuildContext context) {
  final GlobalRouteObserver globalObserver = context.read();
  return GoRouter(
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          final TitleController titleController = context.read();

          titleController.title = titleFromPath(state.topRoute?.path ?? "/");

          return Scaffold(
            appBar: PgpAppBar(
              title: titleController.getTitle(
                title: state.matchedLocation,
                args: state.extra,
              ),
            ),
            floatingActionButton: SmartFab(),
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
                BottomNavigationBarItem(
                  icon: Icon(Icons.group),
                  label: 'Circles',
                ),
              ],
              currentIndex: switch (GoRouterState.of(context).uri.toString()) {
                '/network' => 0,
                '/list' => 2,
                '/circles' => 3,
                _ => 1,
              },
              onTap: (value) {
                context.go(switch (value) {
                  0 => '/network',
                  2 => '/list',
                  3 => '/circles',
                  _ => '/',
                });
              },
            ),
            body: child,
          );
        },
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
          GoRoute(path: '/sign_data', builder: (context, state) => SignData()),
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
            path: '/circles',
            builder: (context, state) {
              final CircleListOptions? options =
                  state.extra as CircleListOptions?;
              return CircleList(parent: options?.parent);
            },
          ),
          GoRoute(
            path: '/path',
            builder: (context, state) =>
                TrustPathView(adapter: state.extra as GraphController),
          ),
          GoRoute(path: '/mycards', builder: (context, state) => Prefs()),
          GoRoute(path: '/scan', builder: (context, state) => VerifyView()),
          GoRoute(path: '/newapp', builder: (context, state) => CreateApp()),
          GoRoute(
            path: '/newcircle',
            builder: (context, state) => CreateCircle(),
          ),
        ],
      ),
    ],
    observers: [globalObserver],
  );
}
