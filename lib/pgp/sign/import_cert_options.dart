import 'package:kata/src/rust/api/ser.dart';

class ImportCertOptions {
  final VerifyResult? content;
  final String fingerprint;
  const ImportCertOptions({required this.fingerprint, this.content});
}
