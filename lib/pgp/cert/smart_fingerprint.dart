import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kata/pgp/wot/cert_list_args.dart';
import 'package:kata/src/rust/api/pgp.dart';

class SmartFingerprint extends StatelessWidget {
  final UserHandle fingerprint;

  const SmartFingerprint({super.key, required this.fingerprint});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fp = fingerprint.name();
    return ExpansionTile(
      title: Text(
        fingerprint.compositeLujvo(),
        style: theme.textTheme.bodySmall,
      ),
      children: [
        TextButton(
          child: Text(fp, style: theme.textTheme.bodySmall),
          onPressed: () => context.push(
            '/list',
            extra: CertListArgs(fingerprint: fingerprint),
          ),
        ),
      ],
    );
  }
}
