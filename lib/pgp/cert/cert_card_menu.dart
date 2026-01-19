import 'package:kata/pgp/cert/cert_delete_dialog.dart';
import 'package:kata/prefs/pref_keys.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/pgp.dart';
import 'package:kata/src/rust/api/pgp/cert.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _CertCardMenuState extends State<CertCardMenu> {
  final FocusNode _buttonFocusNode = FocusNode(debugLabel: 'Menu');
  final MenuController _controller = MenuController();

  @override
  Widget build(BuildContext context) {
    final PgpApp pgpApp = context.read();
    final SharedPreferencesAsync prefs = context.read();
    final sm = ScaffoldMessenger.of(context);
    return MenuAnchor(
      controller: _controller,
      menuChildren: [
        if (widget.signable)
          MenuItemButton(
            child: const Text('sign'),
            onPressed: () => context.push('/sign', extra: widget.cert),
          ),
        MenuItemButton(
          child: const Text('delete'),
          onPressed: () async => await showDialog(
            context: context,
            builder: (ctx) =>
                CertDeleteDialog(identity: widget.cert, context: context),
          ),
        ),
        if (widget.cert.cert.hasPrivate)
          MenuItemButton(
            child: const Text('upload'),
            onPressed: () async {
              final servers =
                  await prefs.getStringList(prefKeyserverList) ??
                  defaultKeyservers;
              for (final server in servers) {
                try {
                  await pgpApp.uploadToKeyserver(
                    fingerprint: UserHandle.fromHex(
                      hex: widget.cert.cert.fingerprint,
                    ),
                    server: server,
                  );
                } on Exception catch (e) {
                  sm.showSnackBar(
                    SnackBar(
                      content: Text(
                        'failed to upload certificate to $server: $e',
                      ),
                    ),
                  );
                }
              }
              sm.showSnackBar(
                SnackBar(content: const Text('Uploaded certificate')),
              );
            },
          ),
        if (!widget.active && widget.cert.cert.hasPrivate)
          MenuItemButton(
            child: const Text('set active'),
            onPressed: () async => await pgpApp.updateRole(
              fingerprint: UserHandle.fromHex(
                hex: widget.cert.cert.fingerprint,
              ),
              role: "primary",
            ),
          ),
      ],
      builder: (ctx, controller, child) => TextButton(
        focusNode: _buttonFocusNode,
        onPressed: () {
          if (controller.isOpen) {
            controller.close();
          } else {
            controller.open();
          }
        },
        child: const Text('More actions'),
      ),
    );
  }
}

class CertCardMenu extends StatefulWidget {
  final PgpCertWithIds cert;
  final bool signable;
  final bool active;

  const CertCardMenu({
    super.key,
    required this.cert,
    required this.signable,
    required this.active,
  });

  @override
  State<StatefulWidget> createState() => _CertCardMenuState();
}
