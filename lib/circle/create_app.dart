import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kata/circle/app_card.dart';

import 'package:kata/fab_observer.dart';
import 'package:kata/fab_state.dart';
import 'package:kata/pgp/cert/active_cert.dart';
import 'package:kata/pgp/cert/cert_selector.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/pgp.dart';
import 'package:kata/src/rust/api/pgp/circles/app.dart';
import 'package:provider/provider.dart';

class _CreateAppState extends State<CreateApp> {
  UserHandle? _circleId;
  CircleApp? _circle;
  late final FabState state = context.read();

  late final FabObserver observer = FabObserver(
    handler: () async {
      final PgpApp pgpApp = context.read();
      await _circle?.toDb(db: pgpApp.getDb());
      if (mounted) context.pop();
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

  Widget buildApp(BuildContext context, Widget Function(BuildContext) card) {
    final PgpApp pgpApp = context.read();

    return Column(
      children: [
        if (_circle != null)
          Flexible(
            flex: 2,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [card(context)],
            ),
          ),

        Expanded(
          flex: 3,
          child: CertSelector(
            selected: (l) async {
              final ActiveCert cert = context.read();
              final activeCert = cert.cert;
              if (activeCert != null && _circle == null) {
                final c = await pgpApp.createApp(
                  owner: activeCert.cert.fingerprint,
                );

                for (final member in l) {
                  await c.addUser(
                    user: member.fingerprint(),
                    tag: MemberTag.merge,
                  );
                }

                final id = c.getIdUserhandle();

                setState(() {
                  _circle = c;
                  _circleId = id;
                });
              } else if (_circle != null) {
                for (final member in l) {
                  await _circle?.addUser(
                    user: member.fingerprint(),
                    tag: MemberTag.merge,
                  );
                  setState(() {});
                }
              }
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final PgpApp pgpApp = context.read();
    return Column(
      children: [
        Expanded(
          child: buildApp(
            context,
            (_) => AppCard(
              members: _circle!,
              id: _circleId!,
              onChange: (value) async {
                final circle = _circle;
                if (value != null && circle != null) {
                  await pgpApp.getDb().updateTag(
                    tag: value.name.name,
                    member: circle.idHex(),
                  );
                }
              },
            ),
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
