import 'package:flutter/material.dart';
import 'package:kata/circle/omni_card.dart';
import 'package:kata/fab_observer.dart';
import 'package:kata/fab_state.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/db/connection.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';
import 'package:provider/provider.dart';

class _CircleListState extends State<CircleList> {
  List<CircleOr>? _members;

  late final FabState fabState = context.read();
  late final Watcher _watcher;

  late final FabObserver observer = FabObserver(
    handler: () async {
      final PgpApp app = context.read();
      if (widget.parent != null) {
        final circles = await app.getCircleById(id: widget.parent!);

        final members = await circles?.iterMembers().toList();

        setState(() {
          _members = members
              ?.where((v) => v.content != null)
              .map((v) => v.content!)
              .toList();
        });
      } else {
        final circles = await app.getDb().getCirclesJoin();
        final c = await app.circlesFromDb(
          members: circles,
          users: false,
          all: true,
        );

        setState(() {
          _members = c;
        });
      }
    },
  );

  @override
  void initState() {
    super.initState();
    fabState.addHandler(observer);
    final PgpApp pgpApp = context.read();
    _watcher = pgpApp.getWatcher();
    _watcher.watch(
      table: 'circle_members',
      cb: (_) {
        if (widget.parent != null) {
          pgpApp.getCircleById(id: widget.parent!).then((circles) async {
            final members = await circles?.iterMembers().toList();

            if (mounted) {
              setState(() {
                _members = members
                    ?.where((v) => v.content != null)
                    .map((v) => v.content!)
                    .toList();
              });
            }
          });
        } else {
          pgpApp.getDb().getCirclesJoin().then((circles) async {
            final c = await pgpApp.circlesFromDb(
              members: circles,
              users: false,
              all: true,
            );
            if (mounted) {
              setState(() {
                _members = c;
              });
            }
          });
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    fabState.removeHandler(observer);
    _watcher.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final members = _members;
    if (members != null) {
      return ListView(
        children: members
            .map((v) => OmniCard(circle: v, expanded: true, noclick: false))
            .toList(),
      );
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
