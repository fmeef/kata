import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kata/pgp/cert/cert_selector.dart';
import 'package:kata/pgp/wot/cert_list.dart';
import 'package:kata/pgp/wot/cert_list_args.dart';
import 'package:kata/src/rust/api/pgp/cert.dart';
import 'package:provider/provider.dart';

enum Mode { App, Circle }

class _CreateAppState extends State<CreateApp> {
  Mode _mode = Mode.Circle;
  List<PgpCertWithIds> _selected = [];
  Widget buildApp(BuildContext context) {
    return Column();
  }

  Widget buildCircle(BuildContext context) {
    return Column(
      children: [
        Text('List cards'),
        Expanded(child: CertSelector()),
        ElevatedButton(onPressed: () => (), child: const Text('Confirm')),
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
