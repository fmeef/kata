import 'package:kata/pgp/wot/graph_controller.dart';
import 'package:kata/prefs/pref_keys.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/pgp.dart';
import 'package:kata/src/rust/api/pgp/cert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IdentityService {
  final PgpApp pgpApp;
  final SharedPreferencesAsync prefs;
  const IdentityService({required this.pgpApp, required this.prefs});

  Future<void> uploadToKeyserver(PgpCertWithIds cert) async {
    final serverList =
        await prefs.getStringList(prefKeyserverList) ?? defaultKeyservers;

    for (final server in serverList) {
      await pgpApp.uploadToKeyserver(
        fingerprint: UserHandle.fromHex(hex: cert.cert.fingerprint),
        server: server,
      );
    }
  }

  Future<void> fillFromKeyserver(String fingerprint) async {
    final serverList =
        await prefs.getStringList(prefKeyserverList) ?? defaultKeyservers;

    for (final server in serverList) {
      await pgpApp.fillFromKeyserver(
        fingerprint: UserHandle.fromHex(hex: fingerprint),
        server: server,
      );
      await pgpApp.uploadToKeyserver(
        fingerprint: UserHandle.fromHex(hex: fingerprint),
        server: server,
      );
    }
  }

  Future<GraphController> authenticate({
    required List<String> roots,
    required String fingerprint,
    required num trust,
  }) async {
    final network = pgpApp.networkFromFingerprints(fingerprints: roots);

    final graph = await network.authenticate(
      remote: fingerprint,
      trust: BigInt.from(trust),
    );

    final target = await pgpApp.getKeyFromFingerprint(
      fingerprint: UserHandle.fromHex(hex: fingerprint),
    );
    // Graph output = Graph();
    // convertWotGraph(output, graph);

    return GraphController(graph: graph, target: target);
  }
}
