import 'package:flutter/material.dart';
import 'package:kata/circle/circle_card_menu.dart';
import 'package:kata/circle/member_entry.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/db/connection.dart';
import 'package:kata/src/rust/api/pgp.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';
import 'package:kata/src/rust/api/pgp/circles/circle.dart';
import 'package:provider/provider.dart';

class _CircleCardState extends State<CircleCard> {
  List<Widget>? _members;
  Watcher? _watcher;
  late final PgpApp pgpApp = context.read();

  @override
  void initState() {
    super.initState();

    Watcher watcher = pgpApp.getWatcher();

    watcher.watch(
      table: 'circle_update',
      cb: (_) async {
        final m = await widget.members.getMembers();
        final v = m
            .map((item) => MemberEntry(entry: item, noclick: widget.noclick))
            .toList();
        if (mounted) {
          setState(() {
            _members = v;
          });
        }
      },
    );

    _watcher = watcher;
  }

  @override
  void dispose() {
    super.dispose();
    _watcher?.dispose();
  }

  List<Widget> getChildren(BuildContext context) {
    final m = _members;

    if (m == null) {
      return [Center(child: CircularProgressIndicator())];
    }

    return (switch (widget.constrained) {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: widget.cardColor,
      child: Padding(
        padding: EdgeInsetsGeometry.fromSTEB(16, 8, 16, 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ExpansionTile(
                initiallyExpanded: widget.expanded,
                leading: Chip(label: Text('${_members?.length}')),
                title: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsetsGeometry.directional(end: 8),
                      child: Icon(Icons.group),
                    ),
                    Expanded(
                      child: Text(
                        widget.id.separateLujvo().joinGismu(),
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
                trailing: CircleCardMenu(
                  circle: CircleOr.circle(widget.members),
                ),
                children: getChildren(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircleCard extends StatefulWidget {
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
  State<StatefulWidget> createState() => _CircleCardState();
}
