import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kata/pgp/wot/cert_list_args.dart';
import 'package:kata/src/rust/api/pgp.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          child: (switch (mode) {
            FingerprintMode.fingerprint => Text(
              fp,
              style: theme.textTheme.bodySmall,
            ),
            FingerprintMode.lojban => Text(
              widget.fingerprint.compositeLujvoOrElse(short: widget.short),
              style: theme.textTheme.bodySmall,
            ),
            FingerprintMode.userid => Text(
              fp,
              style: theme.textTheme.bodySmall,
            ),
          }),
          onPressed: () => context.push(
            '/list',
            extra: CertListArgs(fingerprint: widget.fingerprint),
          ),
        ),
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
