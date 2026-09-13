import 'package:flutter/material.dart';
import 'package:kata/circle/circle_list_options.dart';
import 'package:kata/circle/extensions.dart';
import 'package:kata/pgp/cert/smart_fingerprint.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';
import 'package:kata/src/rust/api/pgp/fingerprint/visual_key.dart';
import 'package:kata/title_controller.dart';

class MemberEntry extends StatelessWidget {
  final CircleEntry entry;
  final bool noclick;
  const MemberEntry({super.key, required this.entry, this.noclick = true});

  @override
  Widget build(BuildContext context) {
    final content = entry.content;
    final icon = entry.getIcon();
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
          if (noclick)
            Expanded(
              child: SmartFingerprint(
                fingerprint: id,
                mode: FingerprintMode.userid,
                builder: builder,
              ),
            )
          else
            Expanded(
              child: SmartFingerprint(
                fingerprint: id,
                builder: builder,
                mode: FingerprintMode.userid,
                onTap: (id) => context.pushAlt(
                  path: '/circles',
                  extra: CircleListOptions(parent: entry.id),
                  alt: entry.id.id.separateLujvo().joinGismu(),
                ),
              ),
            ),
        ],
      );
    } else {
      final id = entry.id.id;
      final builder = VisualKeyBuilder.fromHandle(
        data: id,
      ).lujvo(start: BigInt.from(0), end: BigInt.from(16));
      return Row(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.directional(end: 8),
            child: Icon(icon),
          ),
          if (noclick)
            Expanded(
              child: SmartFingerprint(
                fingerprint: id,
                mode: FingerprintMode.userid,
                builder: builder,
              ),
            )
          else
            Expanded(
              child: SmartFingerprint(
                fingerprint: id,
                builder: builder,
                mode: FingerprintMode.userid,
                onTap: (id) => context.pushAlt(
                  path: '/circles',
                  extra: CircleListOptions(parent: id.handle()),
                  alt: id.getName(),
                ),
              ),
            ),
        ],
      );
    }
  }
}
