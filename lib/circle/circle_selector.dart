import 'package:flutter/material.dart';
import 'package:kata/src/rust/api/db/connection.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';

class _CircleSelectorState extends State<CircleSelector> {
  Watcher? watcher;
  @override
  Widget build(BuildContext context) {
    return Column();
  }
}

class CircleSelector extends StatefulWidget {
  final CircleHandle? parent;
  const CircleSelector({super.key, this.parent});

  @override
  State<StatefulWidget> createState() => _CircleSelectorState();
}
