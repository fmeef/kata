import 'dart:typed_data';

import 'package:kata/src/rust/api.dart';
import 'package:flutter/material.dart';
import 'package:github_identicon/github_identicon.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SigCard extends StatelessWidget {
  final Uint8List? data;
  final String fingerprint;
  final String userid;
  final String? handle;
  final String? description;
  final PgpApp pgpApp;
  final bool disableQr;

  const SigCard({
    super.key,
    required this.fingerprint,
    required this.pgpApp,
    required this.userid,
    this.handle,
    this.description,
    this.data,
    this.disableQr = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.fromSTEB(16, 8, 16, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.fromSTEB(8, 8, 16, 8),
                  child: GitHubIdenticon(seed: fingerprint, size: 64),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsGeometry.fromSTEB(0, 0, 0, 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userid,
                              softWrap: true,
                              style: theme.textTheme.headlineSmall,
                            ),
                            if (handle != null)
                              Text(handle!, style: theme.textTheme.labelLarge),
                            Text(
                              fingerprint,
                              softWrap: true,
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (data != null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  if (!disableQr)
                    QrImageView.withQr(
                      qr: QrCode.fromUint8List(
                        data: data!,
                        errorCorrectLevel: QrErrorCorrectLevel.M,
                      ),
                      size: 256,
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [if (description != null) Text(description!)],
                    ),
                  ),
                ],
              )
            else if (!disableQr)
              Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
