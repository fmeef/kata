import 'dart:io';

import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/pgp/cert.dart';
import 'package:path_provider/path_provider.dart';

class PgpService {
  PgpApp? _app;
  PgpCertWithIds? activeCert;
  Future<PgpApp> _getService() async {
    final appSupport = await getApplicationSupportDirectory();
    final kata = Directory("${appSupport.path}/Kata");
    await kata.create(recursive: true);
    final keyStore = Directory("${kata.path}/main.keystore");
    await keyStore.create();
    final db = "${kata.path}/keys.sqlite3";
    final pgpApp = await PgpApp.create(
      config: Config(keystorePath: keyStore.path, dbPath: db),
    );

    _app = pgpApp;

    return pgpApp;
  }

  Future<PgpApp> getService() async {
    return _app ?? await _getService();
  }

  PgpApp getServiceSync() {
    return Future.sync(_getService) as PgpApp;
  }

  PgpApp? tryGetService() {
    return _app;
  }
}
