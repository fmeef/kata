import 'package:kata/db_provider.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/pgp/cert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActiveCertProvider extends StatelessWidget {
  final Widget Function(BuildContext, PgpCertWithIds?) builder;
  final BuildContext? context;
  const ActiveCertProvider({super.key, required this.builder, this.context});

  @override
  Widget build(BuildContext context) {
    final actualContext = (switch (this.context) {
      null => context,
      _ => this.context,
    })!;
    final PgpApp pgpApp = actualContext.read();
    return DbProvider<PgpCertWithIds>(
      pgpApp: pgpApp,
      builder: (BuildContext ctx, dynamic cert) => builder(actualContext, cert),
      create: (_) async {
        return await pgpApp.getCertByRole(role: 'primary');
      },
    );
  }
}
