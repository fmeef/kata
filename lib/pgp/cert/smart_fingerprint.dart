import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_marquee_plus/flutter_marquee_plus.dart';
import 'package:kata/prefs/pref_keys.dart';
import 'package:kata/src/rust/api/pgp.dart';
import 'package:kata/src/rust/api/pgp/fingerprint/visual_key.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

FutureOr<void> onTapDefault(UserHandle _) {}

enum FingerprintMode {
  userid("User ID"),
  lojban("Lojban"),
  fingerprint("Fingerprint");

  const FingerprintMode(this.name);
  final String name;

  static FingerprintMode? fromString(String mode) {
    return (switch (mode) {
      "User ID" => FingerprintMode.userid,
      "Lojban" => FingerprintMode.lojban,
      "Fingerprint" => FingerprintMode.fingerprint,
      _ => null,
    });
  }

  static final List<String> entries = UnmodifiableListView(
    values.map((v) => v.name),
  );
}

class _SmartFingerprintState extends State<SmartFingerprint> {
  late FingerprintMode? _mode = widget.mode;
  late final SharedPreferencesAsync _prefs;
  VisualKeyOr? visualKey;
  UserHandle? displayFp;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _prefs = context.read();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _prefs.getString(prefFingerprintMode).then((v) {
          if (widget.mode == null) {
            if (mounted && v != null) {
              setState(() {
                _mode = FingerprintMode.fromString(v);
              });
            }
          }
        });
      });
    }
  }

  List<Widget> lojbanInner(VisualKey field0) {
    final theme = Theme.of(context);

    return (field0.gismu
                ?.map((v) => Text(v, style: theme.textTheme.bodySmall))
                .toList() ??
            []) +
        [
          if (field0.phone != null)
            Text(field0.phone ?? "", style: theme.textTheme.bodySmall),
        ];
  }

  Widget lojban() {
    final theme = Theme.of(context);
    return (switch (visualKey) {
      VisualKeyOr_Gismu(:final field0) => Expanded(
        child: (switch (widget.onTap) {
          null => Wrap(spacing: 4, children: lojbanInner(field0)),
          _ => InkWell(
            onTap: () async => await widget.onTap!(widget.fingerprint),
            child: Wrap(spacing: 4, children: lojbanInner(field0)),
          ),
        }),
      ),
      VisualKeyOr_Name(:final field0) => Expanded(
        child: Wrap(
          children: [
            if (widget.onTap != null)
              TextButton(
                onPressed: () async => await widget.onTap!(widget.fingerprint),
                child: Text(field0, style: theme.textTheme.bodySmall),
              )
            else
              Text(field0, style: theme.textTheme.bodySmall),
          ],
        ),
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
        (switch (_mode ?? FingerprintMode.lojban) {
          FingerprintMode.fingerprint => Expanded(
            child: Wrap(
              children: [
                if (widget.onTap != null)
                  TextButton(
                    onPressed: () async =>
                        await widget.onTap!(widget.fingerprint),
                    child: Text(fp, style: theme.textTheme.bodySmall),
                  )
                else
                  Text(fp, style: theme.textTheme.bodySmall),
              ],
            ),
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
                child: (switch (widget.onTap) {
                  null => MarqueePlus(
                    text: comment,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    style: theme.textTheme.bodySmall,
                  ),
                  _ => InkWell(
                    onTap: () async => await widget.onTap!(widget.fingerprint),
                    child: MarqueePlus(
                      text: comment,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                }),
              ),
            ),
          }),
        }),

        if (_mode == FingerprintMode.fingerprint)
          IconButton(
            onPressed: () => setState(() {
              _mode = widget.mode;
            }),
            icon: const Icon(Icons.remove_outlined),
          )
        else
          IconButton(
            onPressed: () => setState(() {
              _mode = FingerprintMode.fingerprint;
            }),
            icon: const Icon(Icons.remove_red_eye_outlined),
          ),
      ],
    );
  }
}

class SmartFingerprint extends StatefulWidget {
  final UserHandle fingerprint;
  final FingerprintMode? mode;
  final bool short;
  final VisualKeyBuilder builder;
  final FutureOr<void> Function(UserHandle)? onTap;

  const SmartFingerprint({
    super.key,
    required this.fingerprint,
    required this.builder,
    this.mode,
    this.short = false,
    this.onTap,
  });

  @override
  State<StatefulWidget> createState() => _SmartFingerprintState();
}
