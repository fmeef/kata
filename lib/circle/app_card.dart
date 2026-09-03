import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:kata/circle/app_member_entry.dart';
import 'package:kata/circle/circle_card_menu.dart';
import 'package:kata/src/rust/api/pgp.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';
import 'package:kata/src/rust/api/pgp/circles/app.dart';

typedef IconEntry = DropdownMenuEntry<AppTag>;

enum AppTag {
  merge(MemberTag.merge, Icons.merge),
  delete(MemberTag.delete, Icons.delete),
  overwrite(MemberTag.overwrite, Icons.find_replace);

  const AppTag(this.name, this.icon);
  final MemberTag name;
  final IconData icon;

  static final List<IconEntry> entries = UnmodifiableListView(
    values.map(
      (icon) => IconEntry(
        label: icon.name.name,
        value: icon,
        leadingIcon: Icon(icon.icon),
      ),
    ),
  );
}

class _AppCardState extends State<AppCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final m = widget.members
        .getMembers()
        .map(
          (item) => AppMemberEntry(
            entry: item,
            onChange: widget.onChange,
            parent: widget.members,
          ),
        )
        .toList();

    return Card(
      color: widget.cardColor,
      child: Padding(
        padding: EdgeInsetsGeometry.fromSTEB(16, 8, 16, 8),
        child: ExpansionTile(
          initiallyExpanded: widget.expanded,
          subtitle: Text(widget.members.getOwner()?.name() ?? ""),
          leading: Chip(label: Text('${m.length}')),
          title: Row(
            children: [
              const Padding(
                padding: EdgeInsetsGeometry.directional(end: 8),
                child: Icon(Icons.apps),
              ),
              Expanded(
                child: Text(
                  widget.id.comment() ?? widget.id.separateLujvo().joinGismu(),
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ],
          ),
          trailing: CircleCardMenu(circle: CircleOr.app(widget.members)),
          children: (switch (widget.constrained) {
            null => m,
            _ => [
              ConstrainedBox(
                constraints: widget.constrained!,
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
    );
  }
}

class AppCard extends StatefulWidget {
  final CircleApp members;
  final UserHandle id;
  final bool expanded;
  final BoxConstraints? constrained;
  final Color? cardColor;
  final FutureOr<void> Function(CircleHandle, AppTag?)? onChange;
  const AppCard({
    super.key,
    required this.members,
    required this.id,
    this.expanded = false,
    this.onChange,
    this.cardColor,
    this.constrained,
  });

  @override
  State<StatefulWidget> createState() => _AppCardState();
}
