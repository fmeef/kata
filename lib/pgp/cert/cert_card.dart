import 'dart:async';

import 'package:kata/pgp/cert/active_cert.dart';
import 'package:kata/pgp/cert/automicon.dart';
import 'package:kata/pgp/cert/cert_card_menu.dart';
import 'package:kata/pgp/cert/smart_fingerprint.dart';
import 'package:kata/pgp/wot/cert_list_args.dart';
import 'package:kata/pgp/wot/graph_controller.dart';
import 'package:kata/pgp/wot/sig_list.dart';
import 'package:kata/src/rust/api/pgp/cert.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kata/src/rust/api/pgp/fingerprint/visual_key.dart';
import 'package:provider/provider.dart';

class _CertCardState extends State<CertCard> {
  bool _selected = false;

  Color colorForTrust(num trust) {
    if (trust > 1 && trust < 120) {
      return Colors.yellow;
    } else if (trust >= 120) {
      return Colors.green;
    } else {
      return Colors.white;
    }
  }

  Widget githubIdenticon(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.fromSTEB(8, 8, 16, 8),
      child: Automicon(
        handle: widget.visualKeyBuilder,
        scale: 3,
        count: 3,
        len: widget.pgpKey.cert.fingerprint.len(),
      ),
    );
  }

  Widget titleExpansionTile(BuildContext context, Set<String> ids) {
    final theme = Theme.of(context);
    if (ids.length > 1) {
      return ExpansionTile(
        minTileHeight: 32,
        tilePadding: EdgeInsetsGeometry.fromSTEB(0, 0, 0, 0),
        childrenPadding: EdgeInsetsGeometry.fromSTEB(0, 0, 0, 0),
        title: Text(
          ids.firstOrNull ?? "N/A",
          style: theme.textTheme.titleSmall,
        ),
        children: ids
            .difference({ids.firstOrNull})
            .map(
              (v) => TextButton(
                onPressed: () =>
                    context.push('/list', extra: CertListArgs(searchUserId: v)),
                child: Text(v),
              ),
            )
            .toList(),
      );
    } else {
      return Padding(
        padding: EdgeInsetsGeometry.fromSTEB(0, 0, 0, 8),
        child: Text(
          widget.pgpKey.ids.firstOrNull ?? "N/A",
          style: theme.textTheme.titleSmall,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ids = widget.pgpKey.ids.toSet();
    final selectable = widget.selectable;

    final ActiveCert activeCert = context.read();
    final cert = activeCert.cert;

    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.fromSTEB(16, 8, 16, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            titleExpansionTile(context, ids),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                githubIdenticon(context),
                Expanded(
                  child: SmartFingerprint(
                    fingerprint: widget.pgpKey.cert.fingerprint,
                    builder: widget.visualKeyBuilder,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CertCardMenu(
                      cert: widget.pgpKey,
                      signable: widget.signable,
                      active: widget.active,
                    ),
                    if (selectable != null)
                      Checkbox(
                        value: _selected,
                        onChanged: (v) async {
                          setState(() {
                            _selected = v ?? false;
                          });
                          await selectable(widget.pgpKey, _selected);
                        },
                      ),
                    if (widget.active && widget.pgpKey.cert.hasPrivate)
                      Chip(
                        label: Text(
                          'Active!',
                          style: TextStyle(color: theme.colorScheme.onTertiary),
                        ),
                        backgroundColor: theme.colorScheme.tertiary,
                      )
                    else if (widget.pgpKey.cert.hasPrivate)
                      Chip(
                        label: Text(
                          'Owned!',
                          style: TextStyle(color: theme.colorScheme.secondary),
                        ),
                        backgroundColor: theme.colorScheme.onSecondary,
                      )
                    else if (cert != null && widget.graphController != null)
                      InkWell(
                        onTap: () async {
                          if (context.mounted) {
                            context.push(
                              '/path',
                              extra: widget.graphController,
                            );
                          }
                        },
                        child: Chip(
                          label: Text('Trust: ${widget.trust}'),
                          backgroundColor: colorForTrust(widget.trust.toInt()),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            SigList(pgpCert: widget.pgpKey),
          ],
        ),
      ),
    );
  }
}

class CertCard extends StatefulWidget {
  final PgpCertWithIds pgpKey;
  final bool active;
  final bool signable;
  final BigInt trust;
  final GraphController? graphController;
  final FutureOr<void> Function(PgpCertWithIds, bool)? selectable;
  late final VisualKeyBuilder visualKeyBuilder;
  final cutoff = 560; // derived from length of themed fingerprint
  final secondCutoff = 560;
  CertCard({
    super.key,
    required this.pgpKey,
    this.active = false,
    this.signable = true,
    this.selectable,
    required this.trust,
    this.graphController,
  }) {
    visualKeyBuilder = VisualKeyBuilder.fromHandle(
      data: pgpKey.cert.fingerprint,
    ).lujvo(start: BigInt.from(0), end: BigInt.from(8));
  }

  @override
  State<StatefulWidget> createState() => _CertCardState();
}
