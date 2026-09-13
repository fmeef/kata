import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kata/circle/app_card.dart';
import 'package:kata/circle/circle_list_options.dart';
import 'package:kata/circle/extensions.dart';
import 'package:kata/pgp/cert/smart_fingerprint.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';
import 'package:kata/src/rust/api/pgp/circles/app.dart';
import 'package:kata/src/rust/api/pgp/fingerprint/visual_key.dart';
import 'package:kata/title_controller.dart';
import 'package:provider/provider.dart';

class _AppMemberEntryState extends State<AppMemberEntry> {
  final MenuController _controller = MenuController();
  final FocusNode _node = FocusNode();
  late MemberTag? _tag = widget.entry.tag;

  Widget chip() {
    if (widget.onChange != null) {
      return DropdownMenu(
        initialSelection: AppTag.merge,
        dropdownMenuEntries: AppTag.entries,
        requestFocusOnTap: false,
        onSelected: (AppTag? it) async =>
            await widget.onChange!(widget.entry.id, it),
      );
    } else {
      return Chip(label: Text(_tag?.name ?? 'cry'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = widget.entry.content;
    final PgpApp pgpApp = context.read();

    if (content != null) {
      final circle = content;
      final id = circle.getIdUserhandle();
      final icon = circle.getIcon();

      final builder = VisualKeyBuilder.fromHandle(
        data: id,
      ).lujvo(start: BigInt.from(0), end: BigInt.from(16));
      return Row(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.directional(end: 8),
            child: Icon(icon),
          ),
          Expanded(
            child: SmartFingerprint(
              fingerprint: id,
              builder: builder,
              mode: FingerprintMode.userid,
              onTap: (v) {
                context.pushAlt(
                  path: '/circles',
                  extra: CircleListOptions(parent: circle.handle()),
                  alt: circle.getName(),
                );
              },
            ),
          ),
          MenuAnchor(
            controller: _controller,
            childFocusNode: _node,
            menuChildren: [
              MenuItemButton(
                child: const Text('purge'),
                onPressed: () async {
                  await widget.parent.remove(
                    handle: widget.entry.id,
                    parent: widget.parent.handle(),
                    delete: false,
                  );
                  await widget.parent.toDb(db: pgpApp.getDb());
                },
              ),
              MenuItemButton(
                child: const Text('delete'),
                onPressed: () async {
                  await widget.parent.remove(
                    handle: widget.entry.id,
                    parent: widget.parent.handle(),
                    delete: true,
                  );

                  setState(() {
                    _tag = MemberTag.delete;
                  });

                  await widget.parent.toDb(db: pgpApp.getDb());
                  await pgpApp.getDb().fireWatcher(table: 'circle_update');
                },
              ),
              MenuItemButton(
                child: const Text('merge'),
                onPressed: () async {
                  await widget.parent.updateTag(
                    id: widget.entry.id,
                    tag: MemberTag.merge,
                  );

                  setState(() {
                    _tag = MemberTag.merge;
                  });

                  await widget.parent.resign();
                  await widget.parent.toDb(db: pgpApp.getDb());
                },
              ),
              MenuItemButton(
                child: const Text('overwrite'),
                onPressed: () async {
                  await widget.parent.updateTag(
                    id: widget.entry.id,
                    tag: MemberTag.overwrite,
                  );
                  setState(() {
                    _tag = MemberTag.overwrite;
                  });
                  await widget.parent.resign();
                  await widget.parent.toDb(db: pgpApp.getDb());
                },
              ),
            ],
            builder: (ctx, controller, child) => InkWell(
              onTap: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
              child: chip(),
            ),
          ),
        ],
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}

class AppMemberEntry extends StatefulWidget {
  final CircleEntry entry;
  final CircleApp parent;
  final FutureOr<void> Function(CircleHandle, AppTag?)? onChange;
  const AppMemberEntry({
    super.key,
    required this.entry,
    required this.onChange,
    required this.parent,
  });

  @override
  State<StatefulWidget> createState() => _AppMemberEntryState();
}
