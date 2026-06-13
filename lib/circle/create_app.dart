import 'package:flutter/material.dart';
import 'package:kata/circle/circle_card.dart';
import 'package:kata/pgp/cert/cert_selector.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/pgp/cert.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';
import 'package:kata/src/rust/api/pgp/circles/circle.dart';
import 'package:provider/provider.dart';

enum Mode { App, Circle }

class _CreateAppState extends State<CreateApp> {
  Mode _mode = Mode.Circle;
  List<MaybeCert> _selected = [];
  List<CircleEntry>? _circle;
  Widget buildApp(BuildContext context) {
    return Column();
  }

  Widget buildCircle(BuildContext context) {
    final PgpApp pgpApp = context.read();
    return Column(
      children: [
        if (_circle != null) Expanded(child: CircleCard(members: _circle!)),
        Text('List cards'),
        Expanded(
          child: CertSelector(
            selected: (l) => setState(() {
              _selected = l;
            }),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            final c = await pgpApp.createCircle(
              keys: _selected
                  .map((v) => CircleOr.fromCert(userHandle: v.fingerprint()))
                  .toList(),
            );

            final members = await c.consumeMembers();

            setState(() {
              _circle = members;
            });
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
            Mode.App => buildApp(context),
            Mode.Circle => buildCircle(context),
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
