import 'package:flutter/material.dart';
import 'package:kata/circle/circle_card_menu.dart';
import 'package:kata/circle/member_entry.dart';
import 'package:kata/src/rust/api/pgp.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';
import 'package:kata/src/rust/api/pgp/circles/circle.dart';

class CircleCard extends StatelessWidget {
  final Circle members;
  final UserHandle id;
  final bool expanded;
  final bool noclick;
  final BoxConstraints? constrained;
  final Color? cardColor;
  const CircleCard({
    super.key,
    required this.members,
    required this.id,
    this.expanded = false,
    this.noclick = false,
    this.constrained,
    this.cardColor,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final m = members
        .getMembers()
        .map((item) => MemberEntry(entry: item, noclick: noclick))
        .toList();

    return Card(
      color: cardColor,
      child: Padding(
        padding: EdgeInsetsGeometry.fromSTEB(16, 8, 16, 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ExpansionTile(
                initiallyExpanded: expanded,
                leading: Chip(label: Text('${m.length}')),
                title: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsetsGeometry.directional(end: 8),
                      child: Icon(Icons.group),
                    ),
                    Expanded(
                      child: Text(
                        id.name(),
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
                trailing: CircleCardMenu(circle: CircleOr.circle(members)),
                children: (switch (constrained) {
                  null => m,
                  _ => [
                    ConstrainedBox(
                      constraints: constrained!,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: m,
                      ),
                    ),
                  ],
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
