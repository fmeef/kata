import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:kata/circle/app_member_entry.dart';
import 'package:kata/src/rust/api/pgp.dart';
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
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final onChange = widget.onChange;
    final theme = Theme.of(context);
    final m = widget.members
        .getMembers()
        .map(
          (item) => Row(
            children: [
              Expanded(child: AppMemberEntry(entry: item)),
              if (onChange != null)
                DropdownMenu(
                  initialSelection: AppTag.merge,
                  dropdownMenuEntries: AppTag.entries,
                  requestFocusOnTap: false,
                  onSelected: (AppTag? entry) async => await onChange(entry),
                ),
            ],
          ),
        )
        .toList();
    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.fromSTEB(16, 8, 16, 8),
        child: ExpansionTile(
          title: Text(
            'App (${widget.id.separateLujvo().joinGismu()})',
            style: theme.textTheme.titleMedium,
          ),
          children: m,
        ),
      ),
    );
  }
}

class AppCard extends StatefulWidget {
  final CircleApp members;
  final UserHandle id;
  final FutureOr<void> Function(AppTag?)? onChange;
  const AppCard({
    super.key,
    required this.members,
    required this.id,
    this.onChange,
  });

  @override
  State<StatefulWidget> createState() => _AppCardState();
}
