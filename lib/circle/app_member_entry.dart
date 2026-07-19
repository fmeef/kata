import 'package:flutter/material.dart';
import 'package:kata/pgp/cert/smart_fingerprint.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';
import 'package:kata/src/rust/api/pgp/fingerprint/visual_key.dart';

class AppMemberEntry extends StatelessWidget {
  final CircleEntry entry;
  const AppMemberEntry({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final content = entry.content;

    if (content != null) {
      final circle = content;
      final id = circle.getIdUserhandle();
      final icon = (switch (circle.getType()) {
        CircleType.user => Icons.person,
        CircleType.circle => Icons.group,
        CircleType.app => Icons.apps,
      });
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
            child: SmartFingerprint(fingerprint: id, builder: builder),
          ),
        ],
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
