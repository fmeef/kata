import 'package:flutter/material.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';

class _CircleListState extends State<CircleList> {
  List<CircleOr>? _members;

  @override
  Widget build(BuildContext context) {
    final members = _members;
    if (members != null) {
      return ListView();
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}

class CircleList extends StatefulWidget {
  const CircleList({super.key});

  @override
  State<StatefulWidget> createState() => _CircleListState();
}
