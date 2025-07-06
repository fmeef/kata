import 'package:kata/pgp/cert/active_cert.dart';
import 'package:kata/pgp/cert/active_cert_provider.dart';
import 'package:kata/pgp/identity_service.dart';
import 'package:kata/pgp/pgp_service.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _PgpViewState extends State<PgpView> {
  final PgpService _service = PgpService();

  @override
  void initState() {
    super.initState();
    _service.getService().then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final service = _service.tryGetService();

    if (service != null) {
      return MultiProvider(
        providers: [
          Provider(create: (ctx) => service),
          Provider(create: (ctx) => Logger()),
          Provider(create: (ctx) => SharedPreferencesAsync()),
        ],
        child: MultiProvider(
          providers: [
            Provider(
              create: (ctx) =>
                  IdentityService(pgpApp: ctx.read(), prefs: ctx.read()),
            ),
          ],
          child: ActiveCertProvider(
            builder: (ctx, cert) => ProxyProvider0(
              update: (_, _) => ActiveCert(cert: cert),
              child: widget.child,
            ),
          ),
        ),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}

class PgpView extends StatefulWidget {
  final Widget child;
  const PgpView({super.key, required this.child});

  @override
  State<StatefulWidget> createState() => _PgpViewState();
}
