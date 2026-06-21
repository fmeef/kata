import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class _TextInputDialogState extends State<TextInputDialog> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(controller: controller),
        Row(
          children: [
            ElevatedButton(
              onPressed: () async {
                widget.onText(controller.text);
                context.pop();
              },
              child: const Text('Submit'),
            ),
            TextButton(
              onPressed: () async {
                widget.onText(null);
                context.pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ],
    );
  }
}

class TextInputDialog extends StatefulWidget {
  final FutureOr<void> Function(String?) onText;
  const TextInputDialog({super.key, required this.onText});

  @override
  State<StatefulWidget> createState() => _TextInputDialogState();
}
