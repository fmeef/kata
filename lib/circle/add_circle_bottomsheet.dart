import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kata/circle/circle_selector.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';
import 'package:kata/src/rust/api/pgp/circles/app.dart';
import 'package:provider/provider.dart';

class _AddCircleBottomsheetState extends State<AddCircleBottomsheet> {
  List<CircleOr> _selected = [];
  late final PgpApp pgpApp = context.read();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CircleSelector(
            parent: widget.parent,
            selected: (sel) => _selected = sel,
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
                    //TODO: allow assigning tag
                    await circle.add(
                      circle: add,
                      tag: MemberTag.merge,
                      db: pgpApp,
                    );
                    if (context.mounted) {
                      context.pop();
                    }
                  }
                }
              },
              child: const Text('Add'),
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
