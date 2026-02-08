import 'package:kata/pgp/cert/smart_fingerprint.dart';
import 'package:kata/pgp/wot/cert_list_args.dart';
import 'package:kata/src/rust/api/pgp/cert.dart';
import 'package:flutter/material.dart';
import 'package:github_identicon/github_identicon.dart';
import 'package:go_router/go_router.dart';

class MiniCard extends StatelessWidget {
  final MaybeCert pgpKey;

  final cutoff = 560; // derived from length of themed fingerprint
  const MiniCard({super.key, required this.pgpKey});

  Widget contentText(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [SmartFingerprint(fingerprint: pgpKey.fingerprint())],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ids = (pgpKey.maybeIds() ?? ['Unknown']).toSet();
    final mq = MediaQuery.sizeOf(context);
    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.fromSTEB(16, 8, 16, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.fromSTEB(8, 0, 16, 0),
                  child: GitHubIdenticon(
                    seed: pgpKey.fingerprint().name(),
                    size: 48,
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
                            style: theme.textTheme.bodyMedium,
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
                            ids.firstOrNull ?? "N/A",
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      if (mq.width >= cutoff) contentText(context),
                    ],
                  ),
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
