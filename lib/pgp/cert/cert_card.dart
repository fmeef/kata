import 'package:kata/pgp/cert/active_cert.dart';
import 'package:kata/pgp/cert/cert_card_menu.dart';
import 'package:kata/pgp/wot/cert_list_args.dart';
import 'package:kata/pgp/wot/graph_controller.dart';
import 'package:kata/pgp/wot/sig_list.dart';
import 'package:kata/src/rust/api/pgp/cert.dart';
import 'package:flutter/material.dart';
import 'package:github_identicon/github_identicon.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CertCard extends StatelessWidget {
  final PgpCertWithIds pgpKey;
  final bool active;
  final bool signable;
  final BigInt trust;
  final GraphController? graphController;
  final cutoff = 560; // derived from length of themed fingerprint
  const CertCard({
    super.key,
    required this.pgpKey,
    this.active = false,
    this.signable = true,
    required this.trust,
    this.graphController,
  });

  Color colorForTrust(num trust) {
    if (trust > 1 && trust < 120) {
      return Colors.yellow;
    } else if (trust >= 120) {
      return Colors.green;
    } else {
      return Colors.white;
    }
  }

  Widget contentText(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(pgpKey.cert.fingerprint, style: theme.textTheme.bodySmall),
        SigList(pgpCert: pgpKey),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ids = pgpKey.ids.toSet();
    final mq = MediaQuery.sizeOf(context);
    final ActiveCert activeCert = context.read();
    final cert = activeCert.cert;
    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.fromSTEB(16, 8, 16, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.fromSTEB(8, 8, 16, 8),
                  child: GitHubIdenticon(
                    seed: pgpKey.cert.fingerprint,
                    size: 64,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (ids.length > 1)
                        ExpansionTile(
                          minTileHeight: 32,
                          tilePadding: EdgeInsetsGeometry.fromSTEB(0, 0, 0, 0),
                          childrenPadding: EdgeInsetsGeometry.fromSTEB(
                            0,
                            0,
                            0,
                            0,
                          ),
                          title: Text(
                            ids.firstOrNull ?? "N/A",
                            style: theme.textTheme.titleSmall,
                          ),
                          children: ids
                              .difference({ids.firstOrNull})
                              .map(
                                (v) => TextButton(
                                  onPressed: () => context.push(
                                    '/list',
                                    extra: CertListArgs(searchUserId: v),
                                  ),
                                  child: Text(v),
                                ),
                              )
                              .toList(),
                        )
                      else
                        Padding(
                          padding: EdgeInsetsGeometry.fromSTEB(0, 0, 0, 8),
                          child: Text(
                            pgpKey.ids.firstOrNull ?? "N/A",
                            style: theme.textTheme.titleSmall,
                          ),
                        ),
                      if (mq.width >= cutoff) contentText(context),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CertCardMenu(
                      cert: pgpKey,
                      signable: signable,
                      active: active,
                    ),
                    if (active && pgpKey.cert.hasPrivate)
                      Chip(
                        label: Text(
                          'Active!',
                          style: TextStyle(color: theme.colorScheme.secondary),
                        ),
                        backgroundColor: theme.colorScheme.onSecondary,
                      )
                    else if (pgpKey.cert.hasPrivate)
                      Chip(
                        label: Text(
                          'Owned!',
                          style: TextStyle(color: theme.colorScheme.onTertiary),
                        ),
                        backgroundColor: theme.colorScheme.tertiary,
                      )
                    else if (cert != null && graphController != null)
                      InkWell(
                        onTap: () async {
                          if (context.mounted) {
                            context.push('/path', extra: graphController);
                          }
                        },
                        child: Chip(
                          label: Text('Trust: $trust'),
                          backgroundColor: colorForTrust(trust.toInt()),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            if (mq.width < cutoff) contentText(context),
          ],
        ),
      ),
    );
  }
}
