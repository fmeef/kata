import 'package:kata/src/rust/api/pgp/cert.dart';

class CertDeleteArgs {
  final PgpCertWithIds cert;
  const CertDeleteArgs({required this.cert});
}
