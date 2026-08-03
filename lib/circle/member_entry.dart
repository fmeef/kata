import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kata/circle/circle_list_options.dart';
import 'package:kata/pgp/cert/smart_fingerprint.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';
import 'package:kata/src/rust/api/pgp/fingerprint/visual_key.dart';

class MemberEntry extends StatelessWidget {
  final CircleEntry entry;
  const MemberEntry({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final content = entry.content;
    final icon = (switch (entry.content?.getType()) {
      CircleType.user => Icons.person,
      CircleType.circle => Icons.group,
      CircleType.app => Icons.apps,
      null => Icons.device_unknown,
    });
    if (content != null) {
      final circle = content;
      final id = circle.getIdUserhandle();
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
              onTap: (id) => context.push(
                '/circles',
                extra: CircleListOptions(parent: id.handle()),
              ),
            ),
          ),
        ],
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
