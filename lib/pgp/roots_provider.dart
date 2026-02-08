import 'package:kata/db_provider.dart';
import 'package:kata/src/rust/api.dart';
import 'package:flutter/material.dart';
import 'package:kata/src/rust/api/pgp.dart';
import 'package:provider/provider.dart';

class RootsProvider extends StatelessWidget {
  final Widget Function(BuildContext, List<UserHandle>?) builder;

  const RootsProvider({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    final PgpApp app = context.read();
    return DbProvider(
      pgpApp: app,
      builder: (BuildContext ctx, dynamic cert) => builder(ctx, cert),
      create: (_) async {
        try {
          final certs = await app.allOwnedCerts();

          return certs.map((v) => v.cert.fingerprint).toList();
        } catch (e) {
          return <UserHandle>[];
        }
      },
    );
  }
}
