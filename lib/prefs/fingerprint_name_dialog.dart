import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kata/pgp/cert/smart_fingerprint.dart';
import 'package:kata/prefs/pref_keys.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _RadioButtonDialogState extends State<FingerprintNameDialog> {
  late final SharedPreferencesAsync _prefs = context.read();

  FingerprintMode _mode = FingerprintMode.lojban;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _prefs.getString(prefFingerprintMode).then((v) {
        if (mounted && v != null) {
          setState(() {
            _mode = FingerprintMode.fromString(v) ?? FingerprintMode.lojban;
          });
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioGroup<FingerprintMode>(
            groupValue: _mode,
            onChanged: (v) async {
              final mode = v ?? FingerprintMode.lojban;
              await _prefs.setString(prefFingerprintMode, mode.name);
              setState(() {
                _mode = mode;
              });
              if (context.mounted) context.pop();
            },
            child: Column(
              children: FingerprintMode.values
                  .map(
                    (v) => ListTile(
                      title: Text(v.name),
                      leading: Radio(value: v),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class FingerprintNameDialog extends StatefulWidget {
  const FingerprintNameDialog({super.key});

  @override
  State<StatefulWidget> createState() => _RadioButtonDialogState();
}
