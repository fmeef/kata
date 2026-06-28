import 'package:flutter/material.dart';
import 'package:kata/circle/create_app.dart';
import 'package:kata/circle/create_circle.dart';

enum Mode { circle, app }

class _CreateCircleAppState extends State<CreateCircleApp> {
  Mode _mode = Mode.circle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioGroup<Mode>(
          groupValue: _mode,
          onChanged: (v) => setState(() {
            _mode = v ?? Mode.circle;
          }),
          child: const Wrap(
            direction: Axis.horizontal,
            children: [
              ListTile(
                title: Text('Circle (sharable list of cards)'),
                leading: Radio<Mode>(value: Mode.circle),
              ),
              ListTile(
                title: Text('App (smart editable list of cards or circles )'),
                leading: Radio<Mode>(value: Mode.app),
              ),
            ],
          ),
        ),
        Expanded(
          child: (switch (_mode) {
            Mode.circle => CreateCircle(),
            Mode.app => CreateApp(),
          }),
        ),
      ],
    );
  }
}

class CreateCircleApp extends StatefulWidget {
  const CreateCircleApp({super.key});

  @override
  State<StatefulWidget> createState() => _CreateCircleAppState();
}
