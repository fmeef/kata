import 'package:flutter/material.dart';
import 'package:kata/pgp/cert/smart_fingerprint.dart';
import 'package:kata/src/rust/api/pgp/circles/app.dart';
import 'package:kata/src/rust/api/pgp/fingerprint/visual_key.dart';

class AppMemberEntry extends StatelessWidget {
  final AppMember entry;
  const AppMemberEntry({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final content = entry.member.member();

    if (content != null) {
      final circle = content.generic();
      final id = circle.getIdUserhandle();
      final builder = VisualKeyBuilder.fromHandle(
        data: id,
      ).lujvo(start: BigInt.from(0), end: BigInt.from(16));
      return SmartFingerprint(fingerprint: id, builder: builder);
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
