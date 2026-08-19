import 'package:flutter/material.dart';
import 'package:kata/circle/omni_card.dart';
import 'package:kata/fab_observer.dart';
import 'package:kata/fab_state.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';
import 'package:provider/provider.dart';

class _CircleListState extends State<CircleList> {
  List<CircleOr>? _members;

  late final FabState fabState = context.read();

  late final FabObserver observer = FabObserver(
    handler: () async {
      final PgpApp app = context.read();
      if (widget.parent != null) {
        final circles = await app.getCirclesForParent(parent: widget.parent!);

        setState(() {
          _members = circles;
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

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => pgpApp.getDb().getCirclesJoin().then((circles) async {
        if (widget.parent != null) {
          final circles = await pgpApp.getCirclesForParent(
            parent: widget.parent!,
          );
          if (mounted) {
            setState(() {
              _members = circles;
            });
          }
        } else {
          final circles = await pgpApp.getDb().getCirclesJoin();
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
        }
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    fabState.removeHandler(observer);
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
