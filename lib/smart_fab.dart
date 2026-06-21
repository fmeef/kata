import 'package:flutter/material.dart';
import 'package:kata/fab_state.dart';
import 'package:kata/go_router_aware.dart';
import 'package:kata/pgp/sign/sign_verify_dialog.dart';
import 'package:logger/web.dart';
import 'package:provider/provider.dart';

class _SmartFabState extends State<SmartFab> with GoRouterAware {
  bool _showFab = true;
  late Logger logger;

  late final FabState state = context.read();

  bool _create = false;

  @override
  void initState() {
    super.initState();
    logger = context.read();
  }

  void showFab({bool create = false}) {
    setState(() {
      _showFab = true;
      _create = create;
    });
  }

  void hideFab() {
    setState(() {
      _showFab = false;
    });
  }

  @override
  void onRoute(String route) {
    final Logger logger = context.read();
    logger.e('onRoute $route');
    (switch (route) {
      '/' => showFab(),
      '/list' => showFab(),
      '/network' => showFab(),
      '/mycards' => showFab(),
      '/newapp' => showFab(create: true),
      _ => hideFab(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: widget.duration,
      offset: _showFab ? Offset.zero : Offset(0, 2),
      child: AnimatedOpacity(
        opacity: _showFab ? 1 : 0,
        duration: widget.duration,
        child: FloatingActionButton(
          onPressed: () async {
            if (_create) {
              await state.notifySave();
            } else {
              await showDialog(
                context: context,
                builder: (ctx) => SignVerifyDialog(context: context),
              );
            }
          },
          child: (switch (_create) {
            false => Icon(Icons.new_label),
            true => Icon(Icons.create),
          }),
        ),
      ),
    );
  }
}

class SmartFab extends StatefulWidget {
  final Duration duration;

  const SmartFab({
    super.key,

    this.duration = const Duration(milliseconds: 500),
  });
  @override
  State<StatefulWidget> createState() => _SmartFabState();
}
