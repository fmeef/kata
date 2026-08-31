import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kata/circle/app_card.dart';
import 'package:kata/circle/circle_list_options.dart';
import 'package:kata/circle/extensions.dart';
import 'package:kata/pgp/cert/smart_fingerprint.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';
import 'package:kata/src/rust/api/pgp/circles/app.dart';
import 'package:kata/src/rust/api/pgp/fingerprint/visual_key.dart';
import 'package:provider/provider.dart';

class AppMemberEntry extends StatelessWidget {
  final CircleEntry entry;
  final CircleApp parent;
  final FocusNode _node = FocusNode();
  final FutureOr<void> Function(CircleHandle, AppTag?)? onChange;
  final MenuController _controller = MenuController();
  AppMemberEntry({
    super.key,
    required this.entry,
    required this.onChange,
    required this.parent,
  });

  Widget chip() {
    if (onChange != null) {
      return DropdownMenu(
        initialSelection: AppTag.merge,
        dropdownMenuEntries: AppTag.entries,
        requestFocusOnTap: false,
        onSelected: (AppTag? it) async => await onChange!(entry.id, it),
      );
    } else {
      return Chip(label: Text(entry.tag?.name ?? 'cry'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = entry.content;
    final PgpApp pgpApp = context.read();
    final theme = Theme.of(context);
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
              onTap: (v) => context.push(
                '/circles',
                extra: CircleListOptions(parent: circle.handle()),
              ),
            ),
          ),
          MenuAnchor(
            controller: _controller,
            childFocusNode: _node,
            menuChildren: [
              MenuItemButton(
                child: const Text('purge'),
                onPressed: () async {
                  await parent.remove(
                    handle: entry.id,
                    parent: parent.handle(),
                    delete: false,
                  );
                  await parent.toDb(db: pgpApp.getDb());
                },
              ),
              MenuItemButton(
                child: const Text('delete'),
                onPressed: () async {
                  await parent.remove(
                    handle: entry.id,
                    parent: parent.handle(),
                    delete: true,
                  );
                  await parent.toDb(db: pgpApp.getDb());
                },
              ),
              MenuItemButton(
                child: const Text('merge'),
                onPressed: () async {
                  parent.updateTag(id: entry.id, tag: MemberTag.merge);
                  await parent.resign();
                  await parent.toDb(db: pgpApp.getDb());
                },
              ),
              MenuItemButton(
                child: const Text('overwrite'),
                onPressed: () async {
                  parent.updateTag(id: entry.id, tag: MemberTag.overwrite);
                  await parent.resign();
                  await parent.toDb(db: pgpApp.getDb());
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
