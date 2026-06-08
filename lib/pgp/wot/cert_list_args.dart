import 'dart:async';

import 'package:kata/src/rust/api/pgp.dart';
import 'package:kata/src/rust/api/pgp/cert.dart';

class CertListArgs {
  final String? grep;
  final String? searchUserId;
  final UserHandle? fingerprint;
  final bool owned;
  final FutureOr<void> Function(List<PgpCertWithIds>)? selectable;

  const CertListArgs({
    this.grep,
    this.searchUserId,
    this.fingerprint,
    this.owned = false,
    this.selectable,
  });

  bool empty() {
    return grep == null && searchUserId == null;
  }
}
