import 'package:kata/pgp/cert/active_cert.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/pgp/import.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:github_identicon/github_identicon.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key});

  Widget headerContent(BuildContext context) {
    final double identiconSize = 100;
    final theme = Theme.of(context);
    final ActiveCert activeCert = context.read();
    final cert = activeCert.cert;

    if (cert != null) {
      return Column(
        children: [
          if (cert.ids.isNotEmpty)
            Text(
              cert.ids.first,
              style: theme.textTheme.titleLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          else
            Text(
              cert.cert.fingerprint,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          GitHubIdenticon(seed: cert.cert.fingerprint, size: identiconSize),
        ],
      );
    } else {
      return const Text('No active card');
    }
  }

  @override
  Widget build(BuildContext context) {
    PgpApp pgp = context.read();

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 77, 113, 175),
          ),
          child: headerContent(context),
        ),

        TextButton(
          onPressed: () {
            context.pop();
            context.push('/generate');
          },
          child: const Text("Generate card"),
        ),
        TextButton(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles();
            if (context.mounted) {
              for (final path in result?.paths ?? List.empty()) {
                await pgp.importCerts(import_: PgpImportFile(path: path));
              }
              if (context.mounted && context.canPop()) context.pop();
            }
          },

          child: const Text("Import cards"),
        ),
        TextButton(
          onPressed: () {
            context.pop();
            context.push('/mycards');
          },
          child: const Text('Settings'),
        ),
      ],
    );
  }
}
