import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:kata/circle/app_member_entry.dart';
import 'package:kata/circle/circle_card_menu.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/db/connection.dart';
import 'package:kata/src/rust/api/pgp.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';
import 'package:kata/src/rust/api/pgp/circles/app.dart';
import 'package:provider/provider.dart';

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
  List<Widget>? _members;
  Watcher? _watcher;
  late final PgpApp pgpApp = context.read();

  @override
  void initState() {
    super.initState();

    Watcher watcher = pgpApp.getDb().getWatcher();

    watcher.watch(
      table: 'circle_update',
      cb: (_) async {
        await updateMembers();
      },
    );
    _watcher = watcher;
  }

  @override
  void didUpdateWidget(covariant AppCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateMembers().ignore();
  }

  @override
  void dispose() {
    super.dispose();
    _watcher?.dispose();
  }

  Future<void> updateMembers() async {
    final m = await widget.members.getMembers();

    final v = m
        .map(
          (item) => AppMemberEntry(
            entry: item,
            onChange: widget.onChange,
            parent: widget.members,
          ),
        )
        .toList();
    if (mounted) {
      setState(() {
        _members = v;
      });
    }
  }

  List<Widget> getMembers(BuildContext context) {
    final members = _members;

    if (members == null) {
      return [Center(child: CircularProgressIndicator())];
    }

    return (switch (widget.constrained) {
      null => members,
      _ => [
        ConstrainedBox(
          constraints: widget.constrained!,
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: members,
          ),
        ),
      ],
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: widget.cardColor,
      child: Padding(
        padding: EdgeInsetsGeometry.fromSTEB(16, 8, 16, 8),
        child: ExpansionTile(
          initiallyExpanded: widget.expanded,
          subtitle: Text(widget.members.getName()),
          leading: Chip(label: Text('${_members?.length}')),
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
          children: getMembers(context),
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
