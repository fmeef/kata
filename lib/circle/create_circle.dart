import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kata/circle/circle_card.dart';
import 'package:kata/fab_observer.dart';
import 'package:kata/fab_state.dart';
import 'package:kata/pgp/cert/cert_selector.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/pgp.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';
import 'package:kata/src/rust/api/pgp/circles/circle.dart';
import 'package:provider/provider.dart';

class _CreateAppState extends State<CreateCircle> {
  UserHandle? _circleId;
  NonOpaqueCircle? _circle;
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
              final c = await pgpApp.createCircle(
                keys: l
                    .map((v) => CircleOr.fromCert(userHandle: v.fingerprint()))
                    .toList(),
              );

              final id = c.getIdUserhandle();
              final members = await c.consumeMembers();

              setState(() {
                _circle = members;
                _circleId = id;
              });
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: buildApp(
            context,
            (_) => Row(
              children: [
                Expanded(
                  child: CircleCard(members: _circle!, id: _circleId!),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CreateCircle extends StatefulWidget {
  const CreateCircle({super.key});

  @override
  State<StatefulWidget> createState() => _CreateAppState();
}
