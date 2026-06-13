import 'package:flutter/material.dart';
import 'package:kata/circle/member_entry.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';
import 'package:kata/src/rust/api/pgp/circles/circle.dart';

class _CircleCardState extends State<CircleCard> {
  List<CircleEntry> _members = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.circle.consumeMembers().then(
        (members) => setState(() {
          _members = members;
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.fromSTEB(16, 8, 16, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Circle', style: theme.textTheme.titleMedium),
            Column(
              children: _members
                  .map((item) => MemberEntry(entry: item))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class CircleCard extends StatefulWidget {
  final Circle circle;
  const CircleCard({super.key, required this.circle});

  @override
  State<StatefulWidget> createState() => _CircleCardState();
}
