import 'package:flutter/material.dart';
import 'package:kata/pgp/cert/cert_card.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/pgp.dart';
import 'package:kata/src/rust/api/pgp/cert.dart';
import 'package:provider/provider.dart';

class _SingleCertState extends State<SingleCert> {
  PgpCertWithIds? _cert;

  @override
  void initState() {
    super.initState();
    final PgpApp pgpApp = context.read();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pgpApp
          .getKeyFromFingerprint(fingerprint: widget.fingerprint)
          .then(
            (cert) => setState(() {
              _cert = cert;
            }),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final cert = _cert;
    if (cert != null) {
      return CertCard(
        pgpKey: MaybeCert.fromCert(cert: cert),
        trust: BigInt.from(0),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}

class SingleCert extends StatefulWidget {
  final UserHandle fingerprint;
  const SingleCert({super.key, required this.fingerprint});

  @override
  State<StatefulWidget> createState() => _SingleCertState();
}
