import 'package:flutter/material.dart';
import 'package:kata/circle/omni_card.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';
import 'package:provider/provider.dart';

class _CircleListState extends State<CircleList> {
  List<CircleOr>? _members;

  @override
  void initState() {
    super.initState();
    final PgpApp pgpApp = context.read();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => pgpApp.getDb().getCirclesJoin().then((circles) async {
        final c = await CircleOr.fromDb(members: circles);
        if (mounted) {
          setState(() {
            _members = c;
          });
        }
      }),
    );
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
