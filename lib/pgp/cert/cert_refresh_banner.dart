import 'package:flutter/material.dart';

class _CertRefreshBannerState extends State<CertRefreshBanner> {
  String current = "";

  @override
  void initState() {
    super.initState();

    widget.controller._listener = (s) => setState(() {
      current = s;
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller._listener = null;
  }

  @override
  Widget build(BuildContext context) {
    return Text('Updating certificate $current');
  }
}

class CertRefreshController {
  void Function(String)? _listener;

  void onUpdate(String name) {
    final listener = _listener;
    if (listener != null) {
      listener(name);
    }
  }
}

class CertRefreshBanner extends StatefulWidget {
  final CertRefreshController controller;
  const CertRefreshBanner({super.key, required this.controller});

  @override
  State<CertRefreshBanner> createState() => _CertRefreshBannerState();
}
