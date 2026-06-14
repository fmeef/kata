import 'package:flutter/material.dart';
import 'package:kata/circle/member_entry.dart';
import 'package:kata/src/rust/api/pgp.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';

class CircleCard extends StatelessWidget {
  final List<CircleEntry> members;
  final UserHandle id;
  const CircleCard({super.key, required this.members, required this.id});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final m = members.map((item) => MemberEntry(entry: item)).toList();
    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.fromSTEB(16, 8, 16, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Circle (${id.separateLujvo().joinGismu()})',
              style: theme.textTheme.titleMedium,
            ),
            Expanded(
              child: ListView(scrollDirection: Axis.vertical, children: m),
            ),
          ],
        ),
      ),
    );
  }
}
