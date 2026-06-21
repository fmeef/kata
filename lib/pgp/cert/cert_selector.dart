import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kata/pgp/cert/mini_card.dart';
import 'package:kata/pgp/roots_provider.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/db/connection.dart';
import 'package:kata/src/rust/api/pgp/cert.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class _CertSelectorState extends State<CertSelector> {
  Watcher? watcher;
  Map<String, MaybeCert>? _certs;
  final Set<String> _selected = {};

  Future<void> updateCerts() async {
    final PgpApp pgp = context.read();
    final Logger logger = context.read();
    setState(() {
      _certs = null;
    });

    List<MaybeCert> n = [];

    try {
      n = await pgp.iterCerts().map((v) => MaybeCert(cert: v)).toList();
    } catch (e) {
      logger.e("exception in cert selector: $e");
      _certs = null;
    }

    setState(() {
      _certs = Map.fromEntries(
        n.map((v) => MapEntry(v.fingerprint().name(), v)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final PgpApp pgp = context.read();
    return RootsProvider(
      builder: (ctx, roots) {
        if (roots == null) {
          return Center(child: CircularProgressIndicator());
        }

        if (watcher == null) {
          final w = pgp.getWatcher();
          w.watch(
            table: "certs",
            cb: (db) async {
              await updateCerts();
            },
          );
          watcher = w;
        }
        final certs = _certs;
        if (certs == null) {
          return Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            Expanded(
              child: ListView(
                children: certs.values.map((cert) {
                  final fp = cert.fingerprint().name();
                  return InkWell(
                    highlightColor: Colors.black,
                    onTap: () async {
                      setState(() {
                        if (_selected.contains(fp)) {
                          _selected.remove(fp);
                        } else {
                          _selected.add(fp);
                        }
                      });

                      final entries =
                          _certs?.entries
                              .where((v) => _selected.contains(v.key))
                              .map((v) => v.value)
                              .toList() ??
                          [];

                      await widget.selected(entries);
                    },
                    child: MiniCard(
                      pgpKey: cert,
                      cardColor: (switch (_selected.contains(fp)) {
                        true => Colors.blue.shade100,
                        false => Colors.white,
                      }),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class CertSelector extends StatefulWidget {
  final FutureOr<void> Function(List<MaybeCert>) selected;
  const CertSelector({super.key, required this.selected});

  @override
  State<StatefulWidget> createState() => _CertSelectorState();
}
