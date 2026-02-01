import 'package:kata/pgp/identity_service.dart';
import 'package:kata/pgp/sign/import_cert_options.dart';
import 'package:kata/pgp/sign/sig_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ImportCertView extends StatelessWidget {
  final ImportCertOptions options;

  const ImportCertView({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    IdentityService pgpApp = context.read();
    final sm = ScaffoldMessenger.of(context);
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          'Received a new identity card!',
          style: theme.textTheme.titleLarge,
        ),
        Text(
          'Make sure to verify the details on this card match the details on the card you scanned '
          'match the details on this card',
        ),
        SigCard(
          fingerprint: options.fingerprint,
          pgpApp: pgpApp.pgpApp,
          userid: options.content?.key?.ids.first ?? "",
          handle: options.content?.content?.handle,
          description: options.content?.content?.description,
          disableQr: true,
        ),

        if (options.content?.isStub == true)
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'This card is a stub! Do you want to refesh it from the internet',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await pgpApp.fillFromKeyserver(
                            options.fingerprint.name(),
                          );
                        } on Exception catch (e) {
                          sm.showSnackBar(
                            SnackBar(
                              content: Text(
                                'Failed to refresh from keyserver: $e',
                              ),
                            ),
                          );
                        }

                        sm.showSnackBar(
                          SnackBar(
                            content: const Text('Successfully refreshed'),
                          ),
                        );

                        if (context.mounted && context.canPop()) context.pop();
                      },
                      child: const Text('Refresh'),
                    ),
                    TextButton(
                      onPressed: () => context.pop(),
                      child: const Text('Save only'),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
