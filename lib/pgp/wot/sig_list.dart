import 'package:kata/pgp/wot/cert_list_args.dart';
import 'package:kata/src/rust/api/pgp/cert.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SigList extends StatelessWidget {
  final PgpCertWithIds pgpCert;

  const SigList({super.key, required this.pgpCert});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sigPlural = (switch (pgpCert.sigs.length) {
      1 => 'sig',
      _ => 'sigs',
    });

    final certPlural = (switch (pgpCert.certifications.length) {
      1 => 'certification',
      _ => 'certifications',
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (pgpCert.sigs.isNotEmpty)
          ExpansionTile(
            title: Text(
              '${pgpCert.sigs.length} $sigPlural',
              style: theme.textTheme.bodySmall,
            ),
            children: pgpCert.sigs
                .map(
                  (v) => TextButton(
                    onPressed: () =>
                        context.push('/list', extra: CertListArgs(grep: v)),
                    child: Text(v),
                  ),
                )
                .toList(),
          ),
        if (pgpCert.certifications.isNotEmpty)
          ExpansionTile(
            title: Text(
              '${pgpCert.certifications.length} $certPlural',
              style: theme.textTheme.bodySmall,
            ),
            children: pgpCert.certifications
                .map(
                  (v) => TextButton(
                    onPressed: () =>
                        context.push('/list', extra: CertListArgs(grep: v)),
                    child: Text(v),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}
