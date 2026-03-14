import 'dart:typed_data';

import 'package:kata/src/rust/api.dart';
import 'package:flutter/material.dart';
import 'package:github_identicon/github_identicon.dart';
import 'package:kata/src/rust/api/pgp.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SigCard extends StatelessWidget {
  final Uint8List? data;
  final UserHandle fingerprint;
  final String userid;
  final String? handle;
  final String? description;
  final PgpApp pgpApp;
  final bool disableQr;
  final Orientation orientation;

  const SigCard({
    super.key,
    required this.fingerprint,
    required this.pgpApp,
    required this.userid,
    this.handle,
    this.description,
    this.orientation = Orientation.landscape,
    this.data,
    this.disableQr = false,
  });

  Widget getQr() {
    final qrContent = QrImageView.withQr(
      qr: QrCode.fromUint8List(
        data: data!,
        errorCorrectLevel: QrErrorCorrectLevel.M,
      ),
      size: 256,
    );

    return switch (orientation) {
      Orientation.landscape => qrContent,
      Orientation.portrait => Center(child: qrContent),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final children = [
      if (!disableQr && data != null) getQr(),
      if (description != null && orientation == Orientation.landscape)
        Expanded(child: Wrap(children: [Text(description!)]))
      else if (description != null)
        Text(description!),
    ];
    final qrchildren = (switch (orientation) {
      Orientation.landscape => children,
      Orientation.portrait => children.reversed,
    }).toList();

    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.fromSTEB(16, 8, 16, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.fromSTEB(8, 8, 16, 8),
                  child: GitHubIdenticon(seed: fingerprint.name(), size: 64),
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
                              fingerprint.name(),
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
              Flex(
                crossAxisAlignment: CrossAxisAlignment.start,
                direction: (switch (orientation) {
                  Orientation.landscape => Axis.horizontal,
                  Orientation.portrait => Axis.vertical,
                }),
                children: qrchildren,
              )
            else if (!disableQr)
              Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
