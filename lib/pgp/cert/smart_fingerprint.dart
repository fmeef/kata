import 'package:flutter/material.dart';
import 'package:flutter_marquee_plus/flutter_marquee_plus.dart';
import 'package:kata/src/rust/api/pgp.dart';
import 'package:kata/src/rust/api/pgp/fingerprint/visual_key.dart';
import 'package:marquee/marquee.dart';

enum FingerprintMode { userid, lojban, fingerprint }

class _SmartFingerprintState extends State<SmartFingerprint> {
  late FingerprintMode mode = widget.mode;
  VisualKeyOr? visualKey;
  UserHandle? displayFp;

  Widget lojban() {
    final theme = Theme.of(context);
    return (switch (visualKey) {
      VisualKeyOr_Gismu(:final field0) => Expanded(
        child: Wrap(
          spacing: 4,
          children:
              (field0.gismu
                      ?.map((v) => Text(v, style: theme.textTheme.bodySmall))
                      .toList() ??
                  []) +
              [
                if (field0.phone != null)
                  Text(field0.phone ?? "", style: theme.textTheme.bodySmall),
              ],
        ),
      ),
      VisualKeyOr_Name(:final field0) => Expanded(
        child: Wrap(children: [Text(field0, style: theme.textTheme.bodySmall)]),
      ),
      _ => Center(child: CircularProgressIndicator()),
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fp = widget.fingerprint.name();

    if (visualKey == null || displayFp != widget.fingerprint) {
      widget.builder.applyOrElse(data: widget.fingerprint).then((v) {
        if (mounted) {
          setState(() {
            visualKey = v;
            displayFp = widget.fingerprint;
          });
        }
      });
    }

    final comment = widget.fingerprint.comment();

    final scaler = MediaQuery.textScalerOf(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        (switch (mode) {
          FingerprintMode.fingerprint => Expanded(
            child: Wrap(children: [Text(fp, style: theme.textTheme.bodySmall)]),
          ),
          FingerprintMode.lojban => lojban(),
          FingerprintMode.userid => (switch (comment) {
            null => lojban(),
            _ => Flexible(
              fit: FlexFit.tight,
              child: SizedBox(
                height:
                    scaler.scale(theme.textTheme.bodySmall?.fontSize ?? 15) *
                    (theme.textTheme.bodySmall?.height ?? 1.0),
                child: MarqueePlus(
                  text: comment,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  style: theme.textTheme.bodySmall,
                ),
              ),
            ),
          }),
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
  final VisualKeyBuilder builder;

  const SmartFingerprint({
    super.key,
    required this.fingerprint,
    required this.builder,
    this.mode = FingerprintMode.lojban,
    this.short = false,
  });

  @override
  State<StatefulWidget> createState() => _SmartFingerprintState();
}
