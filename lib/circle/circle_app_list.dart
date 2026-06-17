import 'package:flutter/material.dart';
import 'package:kata/circle/circle_card.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/pgp/circles/circle.dart';
import 'package:provider/provider.dart';

class _CircleAppListState extends State<CircleAppList> {
  List<NonOpaqueCircle>? _members;
  @override
  Widget build(BuildContext context) {
    final PgpApp pgpApp = context.read();
    pgpApp.getDb().getCirclesJoin().then((c) {});
    return ListView(
      children:
          _members?.map((v) => CircleCard(members: v, id: v.id)).toList() ?? [],
    );
  }
}

class CircleAppList extends StatefulWidget {
  const CircleAppList({super.key});
  @override
  State<StatefulWidget> createState() => _CircleAppListState();
}
