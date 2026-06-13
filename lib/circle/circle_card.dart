import 'package:flutter/material.dart';
import 'package:kata/circle/member_entry.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';

class CircleCard extends StatelessWidget {
  final List<CircleEntry> members;
  const CircleCard({super.key, required this.members});
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
              children: members
                  .map((item) => MemberEntry(entry: item))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
