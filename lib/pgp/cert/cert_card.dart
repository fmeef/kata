import 'package:kata/pgp/cert/active_cert.dart';
import 'package:kata/pgp/cert/automicon.dart';
import 'package:kata/pgp/cert/cert_card_menu.dart';
import 'package:kata/pgp/cert/smart_fingerprint.dart';
import 'package:kata/pgp/wot/cert_list_args.dart';
import 'package:kata/pgp/wot/graph_controller.dart';
import 'package:kata/pgp/wot/sig_list.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/pgp.dart';
import 'package:kata/src/rust/api/pgp/cert.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kata/src/rust/api/pgp/fingerprint/visual_key.dart';
import 'package:provider/provider.dart';

class _CertCardState extends State<CertCard> {
  PgpCertWithIds? _pgpKey;
  UserHandle? _fingerprint;
  late MaybeCert pgpCert = widget.pgpKey;

  @override
  void initState() {
    super.initState();
    final PgpApp pgpApp = context.read();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => (switch (pgpCert) {
        MaybeCert_Full(:final cert) => setState(() {
          _fingerprint = cert.cert.fingerprint;
          _pgpKey = cert;
        }),
        MaybeCert_Fingerprint(:final fingerprint) =>
          pgpApp.getKeyOr(fingerprint: fingerprint()).then((v) {
            if (mounted) {
              setState(() {
                _fingerprint = fingerprint();
                if (v != null) {
                  _pgpKey = v;
                }
              });
            }
          }),
      }),
    );
  }

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
        len: _fingerprint?.len() ?? BigInt.from(0),
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
          _pgpKey?.ids.firstOrNull ?? "N/A",
          style: theme.textTheme.titleSmall,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final signable = widget.signable;
    final visualKeyBuilder = widget.visualKeyBuilder;
    final active = widget.active;
    final graphController = widget.graphController;
    final trust = widget.trust;
    final pgpKey = _pgpKey;
    final ids = pgpKey?.ids.toSet() ?? {};

    final ActiveCert activeCert = context.read();
    final cert = activeCert.cert;
    final fingerprint = _fingerprint;
    if (fingerprint == null) {
      return Center(child: CircularProgressIndicator());
    }

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
              mainAxisSize: MainAxisSize.min,
              children: [
                githubIdenticon(context),
                Expanded(
                  child: SmartFingerprint(
                    fingerprint: fingerprint,
                    builder: visualKeyBuilder,
                  ),
                ),

                if (pgpKey != null)
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
                            style: TextStyle(
                              color: theme.colorScheme.onTertiary,
                            ),
                          ),
                          backgroundColor: theme.colorScheme.tertiary,
                        )
                      else if (pgpKey.cert.hasPrivate)
                        Chip(
                          label: Text(
                            'Owned!',
                            style: TextStyle(
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                          backgroundColor: theme.colorScheme.onSecondary,
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

            if (pgpKey != null) SigList(pgpCert: pgpKey),
          ],
        ),
      ),
    );
  }
}

class CertCard extends StatefulWidget {
  final MaybeCert pgpKey;
  final bool active;
  final bool signable;
  final BigInt trust;
  final GraphController? graphController;
  late final VisualKeyBuilder visualKeyBuilder;
  final cutoff = 560; // derived from length of themed fingerprint
  final secondCutoff = 560;
  CertCard({
    super.key,
    required this.pgpKey,
    this.active = false,
    this.signable = true,
    required this.trust,
    this.graphController,
  }) {
    visualKeyBuilder = VisualKeyBuilder.fromHandle(
      data: pgpKey.fingerprint(),
    ).lujvo(start: BigInt.from(0), end: BigInt.from(8));
  }

  @override
  State<StatefulWidget> createState() => _CertCardState();
}
