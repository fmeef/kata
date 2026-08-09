import 'package:kata/circle/app_card.dart';
import 'package:kata/circle/circle_card.dart';
import 'package:kata/pgp/cert/cert_card.dart';
import 'package:kata/src/rust/api.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kata/src/rust/api/pgp/cert.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';
import 'package:provider/provider.dart';

class CircleDeleteDialog extends StatelessWidget {
  final CircleOr circle;
  final BuildContext context;
  const CircleDeleteDialog({
    super.key,
    required this.circle,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final PgpApp app = this.context.read();
    final userhandle = circle.getIdUserhandle();
    final lujvo = userhandle.separateLujvo().gismu?.join(" ");

    return Dialog(
      child: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Are you sure you want to delete the circle $lujvo",
              style: theme.textTheme.titleLarge,
            ),
            (switch (circle) {
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
                    final hex = userhandle.name();
                    await app.getDb().deleteCircle(id: hex, ty: "circle");
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
