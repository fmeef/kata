import 'package:kata/pgp/cert/smart_fingerprint.dart';
import 'package:kata/prefs/pref_keys.dart';
import 'package:kata/src/rust/api/pgp.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension LojbanHelpers on UserHandle {
  Future<String> gismuOrHex(SharedPreferencesAsync prefs) async {
    final fpmode = await prefs.getString(prefFingerprintMode);

    if (fpmode != null) {
      final mode =
          FingerprintMode.fromString(fpmode) ?? FingerprintMode.fingerprint;

      return switch (mode) {
        FingerprintMode.fingerprint => fingerprint(),
        FingerprintMode.lojban => separateLujvo().joinGismu(),
        FingerprintMode.userid => getName(),
      };
    } else {
      return fingerprint();
    }
  }
}
