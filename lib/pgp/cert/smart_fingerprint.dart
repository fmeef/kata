import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kata/pgp/wot/cert_list_args.dart';
import 'package:kata/src/rust/api/pgp.dart';
import 'package:kata/src/rust/api/pgp/fingerprint.dart';

enum FingerprintMode { userid, lojban, fingerprint }

class _SmartFingerprintState extends State<SmartFingerprint> {
  FingerprintMode mode = FingerprintMode.lojban;

  @override
  void initState() {
    super.initState();
    mode = widget.mode;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fp = widget.fingerprint.name();
    final mp = MediaQuery.sizeOf(context);
    final lujvo = widget.fingerprint.separateLujvoOrElse();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        (switch (mode) {
          FingerprintMode.fingerprint => Expanded(
            child: Wrap(children: [Text(fp, style: theme.textTheme.bodySmall)]),
          ),
          FingerprintMode.lojban => (switch (lujvo) {
            VisualKeyOr_Gismu(:final field0) => Expanded(
              child: Wrap(
                spacing: 4,
                children:
                    field0.gismu
                        .map((v) => Text(v, style: theme.textTheme.bodySmall))
                        .toList() +
                    [Text(field0.phone, style: theme.textTheme.bodySmall)],
              ),
            ),

            VisualKeyOr_Name(:final field0) => Expanded(
              child: Wrap(
                children: [Text(field0, style: theme.textTheme.bodySmall)],
              ),
            ),
          }),
          FingerprintMode.userid => Text(fp, style: theme.textTheme.bodySmall),
        }),
        if (mode == FingerprintMode.fingerprint)
          IconButton(
            onPressed: () => setState(() {
              mode = widget.mode;
            }),
            icon: const Icon(Icons.remove_outlined),
          )
        else
          IconButton(
            onPressed: () => setState(() {
              mode = FingerprintMode.fingerprint;
            }),
            icon: const Icon(Icons.remove_red_eye_outlined),
          ),
      ],
    );
  }
}

class SmartFingerprint extends StatefulWidget {
  final UserHandle fingerprint;
  final FingerprintMode mode;
  final bool short;

  const SmartFingerprint({
    super.key,
    required this.fingerprint,
    this.mode = FingerprintMode.lojban,
    this.short = false,
  });

  @override
  State<StatefulWidget> createState() => _SmartFingerprintState();
}
