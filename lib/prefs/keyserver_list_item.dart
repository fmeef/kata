import 'package:flutter/material.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

class KeyserverListItem extends StatelessWidget {
  final String keyserver;
  final FutureOr<void> Function(String) onDelete;
  const KeyserverListItem({
    super.key,
    required this.keyserver,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.all(8),
        child: Row(
          children: [
            Expanded(child: Text(keyserver)),
            TextButton(
              onPressed: () async => await onDelete(keyserver),
              child: const Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
