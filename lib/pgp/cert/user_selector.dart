import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kata/pgp/cert/cert_selector.dart';
import 'package:kata/pgp/cert/mini_card.dart';
import 'package:kata/src/rust/api/pgp/cert.dart';

class UserSelector extends StatelessWidget {
  final FutureOr<void> Function(List<MaybeCert>) selected;
  const UserSelector({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    return CertSelector<String, MaybeCert>(
      selected: BoxSelected(func: selected),
      valueBuilder: (pgpApp) async => await pgpApp
          .iterCerts()
          .map(
            (v) => KV(
              key: v.cert.fingerprint.name(),
              value: MaybeCert.fromCert(cert: v),
            ),
          )
          .toList(),
      builder: BoxedType(
        func: (ctx, k, v, selected) => MiniCard(
          pgpKey: v,
          cardColor: (switch (selected.contains(k)) {
            true => Colors.blue.shade100,
            false => Colors.white,
          }),
        ),
      ),
    );
  }
}
