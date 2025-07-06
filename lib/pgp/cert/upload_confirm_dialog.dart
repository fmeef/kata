import 'package:kata/prefs/pref_keys.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/pgp/cert.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadConfirmDialog extends StatelessWidget {
  final List<PgpCertWithIds> certs;
  const UploadConfirmDialog({super.key, required this.certs});

  Future<void> uploadCerts(BuildContext context) async {
    if (context.mounted) {
      final PgpApp pgpApp = context.read();
      final SharedPreferencesAsync prefs = context.read();
      final sm = ScaffoldMessenger.of(context);

      final servers =
          await prefs.getStringList(prefKeyserverList) ?? defaultKeyservers;

      for (final cert in certs) {
        for (final server in servers) {
          try {
            await pgpApp.uploadToKeyserver(
              fingerprint: cert.cert.fingerprint,
              server: server,
            );
          } on Exception catch (e) {
            sm.showSnackBar(
              SnackBar(
                content: Text(
                  'failed to upload certificate ${cert.cert.fingerprint}: $e',
                ),
              ),
            );
          }
        }
      }
      if (context.mounted) context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsetsGeometry.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Are you sure you want to upload ${certs.length} certificates',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async => await uploadCerts(context),
                  child: const Text('Upload'),
                ),
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
