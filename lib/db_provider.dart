import 'dart:async';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/db/connection.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class _DbProviderState<T> extends State<DbProvider> {
  late Watcher _watcher;
  T? _item;

  @override
  void initState() {
    final Logger logger = context.read();
    logger.d('watcher init');
    super.initState();
    final watcher = widget.pgpApp.getWatcher();
    watcher.watch(
      table: widget.table,
      cb: (db) async {
        logger.d('watcher prefired ${widget.table}');

        final active = await widget.create(db);
        logger.d('watcher fired $active');

        setState(() {
          _item = active;
        });
      },
    );
    _watcher = watcher;
  }

  @override
  void dispose() {
    super.dispose();
    _watcher.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _item);
  }
}

class DbProvider<T> extends StatefulWidget {
  final PgpApp pgpApp;

  final Widget Function(BuildContext, T?) builder;
  final FutureOr<T?> Function(SqliteDb) create;
  final String table;

  const DbProvider({
    super.key,
    required this.pgpApp,
    required this.builder,
    required this.create,
    this.table = "certs",
  });

  @override
  State<StatefulWidget> createState() => _DbProviderState();
}
