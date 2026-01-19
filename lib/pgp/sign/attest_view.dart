import 'dart:typed_data';

import 'package:kata/pgp/cert/active_cert.dart';
import 'package:kata/pgp/sign/sig_card.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/pgp.dart';
import 'package:kata/src/rust/api/pgp/cert.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class _AttestViewState extends State<AttestView> {
  final handleController = TextEditingController();
  final descriptionController = TextEditingController();
  final ScreenshotController screenshotController = ScreenshotController();
  Uint8List? data;

  Future<void> syncData(PgpApp pgpApp, PgpCertWithIds cert) async {
    final d = await pgpApp.getQr(
      resource: '',
      description: descriptionController.text,
      handle: handleController.text,
      key: UserHandle.fromHex(hex: cert.cert.fingerprint),
      fullKey: true,
    );
    setState(() {
      data = d;
    });
  }

  @override
  Widget build(BuildContext context) {
    final actualContext = (switch (widget.context) {
      null => context,
      _ => widget.context,
    })!;
    final ActiveCert activeCert = actualContext.read();
    final cert = activeCert.cert;
    final PgpApp pgpApp = actualContext.read();

    if (cert != null) {
      return Padding(
        padding: EdgeInsetsGeometry.all(6.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SigCard(
                pgpApp: pgpApp,
                fingerprint: cert.cert.fingerprint,

                handle: handleController.text,
                userid: cert.ids.first,
                description: descriptionController.text,
                data: data,
              ),
              const Text('This is a preview of the card about to be shared'),
              Column(
                children: [
                  TextField(
                    controller: handleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hint: const Text('Handle'),
                    ),
                    onChanged: (_) async => await syncData(pgpApp, cert),
                    onEditingComplete: () async => await syncData(pgpApp, cert),
                  ),
                  TextField(
                    controller: descriptionController,
                    maxLines: null,
                    minLines: 2,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hint: const Text('Description'),
                    ),
                    onChanged: (_) async => await syncData(pgpApp, cert),
                    onEditingComplete: () async => await syncData(pgpApp, cert),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => context.pop(),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final screenshot = await screenshotController
                          .captureFromWidget(
                            SizedBox(
                              width: 600,
                              height: 390,
                              child: SigCard(
                                pgpApp: pgpApp,
                                fingerprint: cert.cert.fingerprint,

                                handle: handleController.text,
                                userid: cert.ids.first,
                                description: descriptionController.text,
                                data: data,
                              ),
                            ),
                          );

                      final shareParams = ShareParams(
                        files: [
                          XFile.fromData(screenshot, mimeType: 'image/png'),
                        ],
                      );

                      SharePlus.instance.share(shareParams);
                    },
                    child: const Text('Sign'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}

class AttestView extends StatefulWidget {
  const AttestView({super.key, this.context});
  final BuildContext? context;
  @override
  State<StatefulWidget> createState() => _AttestViewState();
}
