import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kata/pgp/cert/mini_card.dart';
import 'package:kata/pgp/roots_provider.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/db/connection.dart';
import 'package:kata/src/rust/api/pgp/cert.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class KV<K, T> {
  final K key;
  final T value;

  const KV({required this.key, required this.value});
}

class _CertSelectorState<K, V> extends State<CertSelector<K, V>> {
  Watcher? watcher;
  Map<K, V>? _certs;
  final Set<K> _selected = {};

  Future<void> updateCerts() async {
    final PgpApp pgp = context.read();
    final Logger logger = context.read();
    setState(() {
      _certs = null;
    });

    List<KV<K, V>> n = [];

    try {
      // n = await pgp
      //     .iterCerts()
      //     .map((v) => MaybeCert.fromCert(cert: v))
      //     .toList();

      n = await widget.valueBuilder(pgp);
    } catch (e) {
      logger.e("exception in cert selector: $e");
      _certs = null;
    }

    setState(() {
      _certs = Map.fromEntries(n.map((v) => MapEntry(v.key, v.value)));
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
                children: certs.entries.map((entry) {
                  return InkWell(
                    highlightColor: Colors.black,
                    onTap: () async {
                      final fp = entry.key;

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

                      await widget.selectedBox.use(entries);
                    },
                    child: widget.builderBox.use(
                      ctx,
                      entry.key,
                      entry.value,
                      _selected,
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

typedef BuilderFunction<K, V> = dynamic Function(BuildContext, K, V, Set<K>);

typedef SelectedFunction<V> = FutureOr<void> Function(V);

class BoxedType<K, V> {
  final BuilderFunction<K, V> func;
  const BoxedType({required this.func});
  dynamic use(BuildContext ctx, K k, V v, dynamic s) =>
      func(ctx, k, v, Set<K>.from(s));
}

class BoxSelected<V> {
  final SelectedFunction<List<V>> func;
  const BoxSelected({required this.func});
  FutureOr<void> use(dynamic v) => func(List<V>.from(v));
}

class CertSelector<K, V> extends StatefulWidget {
  late final BoxSelected<V> selectedBox;
  late final BoxedType<K, V> builderBox;
  final BuilderFunction<K, V> builder;
  final SelectedFunction<List<V>> selected;
  final FutureOr<List<KV<K, V>>> Function(PgpApp) valueBuilder;
  CertSelector({
    super.key,
    required this.selected,
    required this.builder,
    required this.valueBuilder,
  }) {
    builderBox = BoxedType(func: builder);
    selectedBox = BoxSelected(func: selected);
  }

  @override
  State<StatefulWidget> createState() => _CertSelectorState();
}
