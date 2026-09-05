import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kata/circle/app_card.dart';
import 'package:kata/circle/circle_selector.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';
import 'package:kata/src/rust/api/pgp/circles/app.dart';
import 'package:provider/provider.dart';

class _AddCircleBottomsheetState extends State<AddCircleBottomsheet> {
  List<CircleOr> _selected = [];
  AppTag? _tag;
  late final PgpApp pgpApp = context.read();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CircleSelector(
            parent: widget.parent,
            users: false,
            selected: (sel) {
              _selected = sel;
              if (sel.any((p) => p.getType() == CircleType.app)) {
                if (_tag == null) {
                  setState(() {
                    _tag = AppTag.merge;
                  });
                }
              } else {
                setState(() {
                  _tag = null;
                });
              }
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () async {
                final add = await pgpApp.getCircleById(id: widget.add);
                if (add != null) {
                  for (final circle in _selected) {
                    await circle.add(
                      circle: add,
                      tag: _tag?.name ?? MemberTag.merge,
                      db: pgpApp,
                    );
                  }
                } else if (widget.add.circleType == CircleType.user) {
                  final add = CircleOr.fromCert(userHandle: widget.add.id);
                  await add.toDb(db: pgpApp.getDb());
                  for (final circle in _selected) {
                    await circle.add(
                      circle: add,
                      tag: _tag?.name ?? MemberTag.merge,
                      db: pgpApp,
                    );
                  }
                }

                if (context.mounted) {
                  context.pop();
                }
              },
              child: const Text('Add'),
            ),
            if (_tag != null)
              DropdownMenu(
                initialSelection: _tag,
                dropdownMenuEntries: AppTag.entries,
                requestFocusOnTap: false,
                onSelected: (AppTag? entry) => setState(() {
                  _tag = entry;
                }),
              ),
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ],
    );
  }
}

class AddCircleBottomsheet extends StatefulWidget {
  final CircleHandle? parent;
  final CircleHandle add;
  const AddCircleBottomsheet({super.key, required this.add, this.parent});

  @override
  State<StatefulWidget> createState() => _AddCircleBottomsheetState();
}
