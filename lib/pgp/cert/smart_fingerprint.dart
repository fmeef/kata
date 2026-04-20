import 'package:flutter/material.dart';
import 'package:kata/src/rust/api/pgp.dart';
import 'package:kata/src/rust/api/pgp/fingerprint/visual_key.dart';

enum FingerprintMode { userid, lojban, fingerprint }

class _SmartFingerprintState extends State<SmartFingerprint> {
  FingerprintMode mode = FingerprintMode.lojban;
  IdenticonKey? visualKey;

  @override
  void initState() {
    super.initState();
    mode = widget.mode;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      VisualKeyBuilder()
          .lujvo(start: BigInt.from(0), end: BigInt.from(8))
          .identicon(
            start: widget.fingerprint.len() - BigInt.from(16),
            end: widget.fingerprint.len(),
            count: 3,
            scale: 8,
          )
          .applyUserhandleOrElse(handle: widget.fingerprint)
          .then(
            (v) => setState(() {
              visualKey = v;
            }),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fp = widget.fingerprint.name();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        (switch (mode) {
          FingerprintMode.fingerprint => Expanded(
            child: Wrap(children: [Text(fp, style: theme.textTheme.bodySmall)]),
          ),
          FingerprintMode.lojban => (switch (visualKey?.text()) {
            VisualKeyOr_Gismu(:final field0) => Expanded(
              child: Wrap(
                spacing: 4,
                children:
                    (field0.gismu
                            ?.map(
                              (v) => Text(v, style: theme.textTheme.bodySmall),
                            )
                            .toList() ??
                        []) +
                    [
                      if (field0.phone != null)
                        Text(
                          field0.phone ?? "",
                          style: theme.textTheme.bodySmall,
                        ),
                    ],
              ),
            ),
            VisualKeyOr_Name(:final field0) => Expanded(
              child: Wrap(
                children: [Text(field0, style: theme.textTheme.bodySmall)],
              ),
            ),
            _ => Center(child: CircularProgressIndicator()),
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
