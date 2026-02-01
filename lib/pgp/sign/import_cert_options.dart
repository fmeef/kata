import 'package:kata/src/rust/api/pgp.dart';
import 'package:kata/src/rust/api/ser.dart';

class ImportCertOptions {
  final VerifyResult? content;
  final UserHandle fingerprint;
  const ImportCertOptions({required this.fingerprint, this.content});
}
