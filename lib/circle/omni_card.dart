import 'package:flutter/material.dart';
import 'package:kata/circle/app_card.dart';
import 'package:kata/circle/circle_card.dart';
import 'package:kata/pgp/cert/cert_card.dart';
import 'package:kata/src/rust/api/pgp/cert.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';

class OmniCard extends StatelessWidget {
  final CircleOr circle;
  final bool expanded;

  const OmniCard({super.key, required this.circle, this.expanded = false});

  @override
  Widget build(BuildContext context) {
    return (switch (circle) {
      CircleOr_Circle(:final field0) => CircleCard(
        id: field0.getIdUserhandle(),
        members: field0,
        expanded: expanded,
      ),
      CircleOr_App(:final field0) => AppCard(
        members: field0,
        expanded: expanded,
        id: field0.getIdUserhandle(),
      ),
      CircleOr_User(:final field0) => CertCard(
        pgpKey: MaybeCert.fingerprint(fpr: field0),
        trust: BigInt.from(0),
      ),
    });
  }
}
