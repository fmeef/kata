import 'package:flutter/material.dart';
import 'package:kata/circle/app_card.dart';
import 'package:kata/circle/circle_card.dart';
import 'package:kata/pgp/cert/cert_selector.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/pgp.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';
import 'package:kata/src/rust/api/pgp/circles/circle.dart';
import 'package:provider/provider.dart';

enum Mode { App, Circle }

class _CreateAppState extends State<CreateApp> {
  Mode _mode = Mode.Circle;

  UserHandle? _circleId;
  NonOpaqueCircle? _circle;
  Widget buildApp(BuildContext context, Widget Function(BuildContext) card) {
    final PgpApp pgpApp = context.read();

    return Column(
      children: [
        if (_circle != null) Flexible(flex: 2, child: card(context)),

        Text('List cards'),
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
    final PgpApp pgpApp = context.read();
    return Column(
      children: [
        RadioGroup<Mode>(
          groupValue: _mode,
          onChanged: (v) => setState(() {
            _mode = v ?? Mode.Circle;
          }),
          child: const Wrap(
            direction: Axis.horizontal,
            children: [
              ListTile(
                title: Text('Circle (sharable list of cards)'),
                leading: Radio<Mode>(value: Mode.Circle),
              ),
              ListTile(
                title: Text('App (smart editable list of cards or circles )'),
                leading: Radio<Mode>(value: Mode.App),
              ),
            ],
          ),
        ),
        Expanded(
          child: (switch (_mode) {
            Mode.Circle => buildApp(
              context,
              (_) => Column(
                children: [
                  Expanded(
                    child: CircleCard(members: _circle!, id: _circleId!),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _circle?.toDb(db: pgpApp.getDb());
                    },
                    child: const Text('Create card'),
                  ),
                ],
              ),
            ),
            Mode.App => buildApp(
              context,
              (_) => AppCard(members: _circle!, id: _circleId!),
            ),
          }),
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
