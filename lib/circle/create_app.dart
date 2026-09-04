import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kata/circle/app_card.dart';
import 'package:kata/circle/circle_list_options.dart';
import 'package:kata/circle/circle_selector.dart';

import 'package:kata/fab_observer.dart';
import 'package:kata/fab_state.dart';
import 'package:kata/pgp/cert/active_cert.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';
import 'package:kata/src/rust/api/pgp/circles/app.dart';
import 'package:provider/provider.dart';

class _CreateAppState extends State<CreateApp> {
  CircleApp? _circle;
  final TextEditingController _controller = TextEditingController();
  late final FabState state = context.read();

  late final FabObserver observer = FabObserver(
    handler: () async {
      final PgpApp pgpApp = context.read();
      await _circle?.toDb(db: pgpApp.getDb());
      if (mounted) context.go('/circles', extra: CircleListOptions());
    },
  );

  @override
  void initState() {
    super.initState();
    state.addHandler(observer);
  }

  @override
  void dispose() {
    super.dispose();
    state.removeHandler(observer);
  }

  @override
  Widget build(BuildContext context) {
    final PgpApp pgpApp = context.read();
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hint: const Text('App name'),
                ),
              ),
              if (_circle != null)
                Flexible(
                  flex: 2,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      AppCard(
                        members: _circle!,
                        expanded: true,
                        constrained: BoxConstraints(maxHeight: 250),
                        id: _circle!.getIdUserhandle(),
                        onChange: (id, value) async {
                          final tag = value?.name;
                          if (tag != null) {
                            _circle?.updateTag(id: id, tag: tag);
                          }
                        },
                      ),
                    ],
                  ),
                ),

              Expanded(
                flex: 3,
                child: CircleSelector(
                  selected: (l) async {
                    final ActiveCert cert = context.read();
                    final activeCert = cert.cert;
                    if (activeCert != null && _circle == null) {
                      final c = await pgpApp.createApp(
                        owner: activeCert.cert.fingerprint,
                        name: _controller.text,
                      );

                      for (final member in l) {
                        (switch (member) {
                          CircleOr_User(:final field0) => await c.addUser(
                            user: field0,
                            tag: MemberTag.merge,
                          ),
                          _ => (),
                        });
                      }

                      setState(() {
                        _circle = c;
                      });
                    } else if (_circle != null) {
                      for (final member in l) {
                        print('add member2 ${member.getIdUserhandle().name()}');

                        (switch (member) {
                          CircleOr_User(:final field0) =>
                            await _circle?.addUser(
                              user: field0,
                              tag: MemberTag.merge,
                            ),
                          _ => (),
                        });
                      }

                      setState(() {});
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CreateApp extends StatefulWidget {
  const CreateApp({super.key});

  @override
  State<StatefulWidget> createState() => _CreateAppState();
}
