import 'package:flutter/material.dart';

class ImportDialog extends StatelessWidget {
  const ImportDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(child: Center(child: CircularProgressIndicator()));
  }
}
