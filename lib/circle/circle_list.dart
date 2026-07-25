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
      final circles = await app.getDb().getCirclesJoin();
      final c = await app.circlesFromDb(members: circles);

      setState(() {
        _members = c;
      });
    },
  );

  @override
  void initState() {
    super.initState();
    fabState.addHandler(observer);
    final PgpApp pgpApp = context.read();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => pgpApp.getDb().getCirclesJoin().then((circles) async {
        final c = await pgpApp.circlesFromDb(members: circles);
        if (mounted) {
          setState(() {
            _members = c;
          });
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
            .map((v) => OmniCard(circle: v, expanded: true))
            .toList(),
      );
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
