import 'package:flutter/material.dart';
import 'package:kata/pgp/cert/smart_fingerprint.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';
import 'package:kata/src/rust/api/pgp/fingerprint/visual_key.dart';

class MemberEntry extends StatelessWidget {
  final CircleEntry entry;
  const MemberEntry({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final id = entry.id;
    final content = entry.content;

    if (content != null) {
      final circle = content.generic();
      final id = circle.getIdUserhandle();
      final lujvo = id.separateLujvo();
      final builder = VisualKeyBuilder.fromHandle(
        data: id,
      ).lujvo(start: BigInt.from(0), end: BigInt.from(16));
      return SmartFingerprint(fingerprint: id, builder: builder);
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
