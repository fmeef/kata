import 'package:flutter/material.dart';
import 'package:kata/circle/omni_card.dart';
import 'package:kata/fab_observer.dart';
import 'package:kata/fab_state.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/db/connection.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';
import 'package:provider/provider.dart';

class _CircleListState extends State<CircleList> {
  List<Widget>? _members;

  late final FabState fabState = context.read();
  late final Watcher _watcher;
  late final PgpApp _pgpApp = context.read();

  Future<void> updateCircles() async {
    if (widget.parent != null) {
      final circles = await _pgpApp.getCircleById(id: widget.parent!);

      final members = await circles?.iterMembers().toList();
      final m = members
          ?.where((v) => v.content != null)
          .map((v) => v.content!)
          .map((v) => OmniCard(circle: v, expanded: true, noclick: false))
          .toList();
      setState(() {
        _members = m;
      });
    } else {
      final circles = await _pgpApp.getDb().getCirclesJoin();
      final m = await _pgpApp.circlesFromDb(
        members: circles,
        users: false,
        all: true,
      );

      final c = m
          .map((v) => OmniCard(circle: v, expanded: true, noclick: false))
          .toList();

      setState(() {
        _members = c;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _watcher = _pgpApp.getWatcher();
    _watcher.watch(
      table: 'circle_members',
      cb: (_) async {
        await updateCircles();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _watcher.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final members = _members;
    if (members != null) {
      return ListView(children: members);
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}

class CircleList extends StatefulWidget {
  final CircleHandle? parent;
  const CircleList({super.key, this.parent});

  @override
  State<StatefulWidget> createState() => _CircleListState();
}
