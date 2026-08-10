import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kata/circle/mini_circle.dart';
import 'package:kata/pgp/cert/cert_selector.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';

class CircleSelector extends StatelessWidget {
  final FutureOr<void> Function(List<CircleOr>) selected;
  final CircleHandle? parent;
  const CircleSelector({super.key, required this.selected, this.parent});

  @override
  Widget build(BuildContext context) {
    return CertSelector<String, CircleOr>(
      selected: selected,
      builder: (ctx, k, v, selected) => MiniCircle(
        handle: v.handle(),
        cardColor: (switch (selected.contains(k)) {
          true => Colors.blue.shade100,
          false => Colors.white,
        }),
      ),
      valueBuilder: (pgpApp) async {
        if (parent != null) {
          return await pgpApp
              .getCirclesForParent(parent: parent!)
              .asStream()
              .map((v) => v.map((v) => KV(key: v.idHex(), value: v)).toList())
              .first;
        } else {
          final circles = await pgpApp.getDb().getCirclesJoin();
          final db = await pgpApp.circlesFromDb(members: circles, users: false);
          return db.map((v) => KV(key: v.idHex(), value: v)).toList();
        }
      },
    );
  }
}
