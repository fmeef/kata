import 'package:flutter/material.dart';
import 'package:kata/circle/circle_list_options.dart';
import 'package:kata/circle/extensions.dart';
import 'package:kata/pgp/cert/smart_fingerprint.dart';
import 'package:kata/prefs/prefs_helpers.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';
import 'package:kata/src/rust/api/pgp/fingerprint/visual_key.dart';
import 'package:kata/title_controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _MemberEntryState extends State<MemberEntry> {
  String _gismu = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final SharedPreferencesAsync prefs = context.read();
      _gismu = await widget.entry.id.id.gismuOrHex(prefs);
    });
  }

  @override
  Widget build(BuildContext context) {
    final content = widget.entry.content;
    final icon = widget.entry.getIcon();
    if (content != null) {
      final circle = content;
      final id = circle.getIdUserhandle();
      final builder = VisualKeyBuilder.fromHandle(
        data: id,
      ).lujvo(start: BigInt.from(0), end: BigInt.from(16));
      return Row(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.directional(end: 8),
            child: Icon(icon),
          ),
          if (widget.noclick)
            Expanded(
              child: SmartFingerprint(
                fingerprint: id,
                mode: FingerprintMode.userid,
                builder: builder,
              ),
            )
          else
            Expanded(
              child: SmartFingerprint(
                fingerprint: id,
                builder: builder,
                mode: FingerprintMode.userid,
                onTap: (id) => context.pushAlt(
                  path: '/circles',
                  extra: CircleListOptions(parent: widget.entry.id),
                  alt: _gismu,
                ),
              ),
            ),
        ],
      );
    } else {
      final id = widget.entry.id.id;
      final builder = VisualKeyBuilder.fromHandle(
        data: id,
      ).lujvo(start: BigInt.from(0), end: BigInt.from(16));
      return Row(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.directional(end: 8),
            child: Icon(icon),
          ),
          if (widget.noclick)
            Expanded(
              child: SmartFingerprint(
                fingerprint: id,
                mode: FingerprintMode.userid,
                builder: builder,
              ),
            )
          else
            Expanded(
              child: SmartFingerprint(
                fingerprint: id,
                builder: builder,
                mode: FingerprintMode.userid,
                onTap: (id) => context.pushAlt(
                  path: '/circles',
                  extra: CircleListOptions(parent: id.handle()),
                  alt: id.getName(),
                ),
              ),
            ),
        ],
      );
    }
  }
}

class MemberEntry extends StatefulWidget {
  final CircleEntry entry;
  final bool noclick;
  const MemberEntry({super.key, required this.entry, this.noclick = true});

  @override
  State<StatefulWidget> createState() => _MemberEntryState();
}
