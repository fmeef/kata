import 'package:kata/src/rust/api/pgp.dart';

class CertListArgs {
  final String? grep;
  final String? searchUserId;
  final UserHandle? fingerprint;
  final bool owned;

  const CertListArgs({
    this.grep,
    this.searchUserId,
    this.fingerprint,
    this.owned = false,
  });

  bool empty() {
    return grep == null && searchUserId == null;
  }
}
