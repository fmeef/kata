import 'package:kata/circle/app_card.dart';
import 'package:kata/circle/circle_card.dart';
import 'package:kata/pgp/cert/cert_card.dart';
import 'package:kata/prefs/prefs_helpers.dart';
import 'package:kata/src/rust/api.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kata/src/rust/api/pgp/cert.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _CircleDeleteDialogState extends State<CircleDeleteDialog> {
  String _lujvo = "";
  late final userhandle = widget.circle.getIdUserhandle();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final SharedPreferencesAsync prefs = context.read();
      _lujvo = await userhandle.gismuOrHex(prefs);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final PgpApp app = this.context.read();

    return Dialog(
      child: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Are you sure you want to delete the circle $_lujvo",
              style: theme.textTheme.titleLarge,
            ),
            (switch (widget.circle) {
              CircleOr_Circle(:final field0) => CircleCard(
                members: field0,
                id: userhandle,
                expanded: true,
              ),
              CircleOr_App(:final field0) => AppCard(
                members: field0,
                id: field0.getIdUserhandle(),
              ),
              CircleOr_User(:final field0) => CertCard(
                pgpKey: MaybeCert.fingerprint(fpr: field0),
                trust: BigInt.from(0),
              ),
            }),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => context.pop(),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () async {
                    final hex = widget.circle.handle();
                    await app.getDb().deleteCircle(
                      id: hex.id.fingerprint(),
                      ty: hex.circleType.name,
                    );
                    await app.getDb().fireWatcher(table: 'circle_update');
                    if (context.mounted) context.pop();
                  },
                  child: const Text('Delete it'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CircleDeleteDialog extends StatefulWidget {
  final CircleOr circle;
  final BuildContext context;
  const CircleDeleteDialog({
    super.key,
    required this.circle,
    required this.context,
  });

  @override
  State<StatefulWidget> createState() => _CircleDeleteDialogState();
}
