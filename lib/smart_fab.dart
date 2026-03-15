import 'package:flutter/material.dart';
import 'package:kata/go_router_aware.dart';
import 'package:kata/pgp/sign/sign_verify_dialog.dart';
import 'package:logger/web.dart';
import 'package:provider/provider.dart';

class _SmartFabState extends State<SmartFab> with GoRouterAware {
  bool _showFab = true;

  late Logger logger;

  @override
  void initState() {
    logger = context.read();

    super.initState();
  }

  @override
  void didPush() {
    setState(() {
      _showFab = true;
    });
  }

  @override
  void didPop() {
    setState(() {
      _showFab = false;
    });
  }

  @override
  void didPopNext() {
    setState(() {
      _showFab = true;
    });
  }

  @override
  void didPushNext() {
    setState(() {
      _showFab = false;
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
          onPressed: () async => await showDialog(
            context: context,

            builder: (ctx) => SignVerifyDialog(context: context),
          ),
          child: const Icon(Icons.new_label),
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
