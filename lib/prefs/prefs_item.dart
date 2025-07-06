import 'package:flutter/material.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

class PrefsItem extends StatelessWidget {
  final Widget? button;
  final String title;
  final String description;
  final FutureOr<void> Function() onTap;
  const PrefsItem({
    super.key,
    required this.description,
    required this.title,
    required this.onTap,
    this.button,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () async => await onTap(),

      child: ListView(
        shrinkWrap: true,
        children: [
          Divider(),
          Padding(
            padding: EdgeInsetsGeometry.all(8),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: theme.textTheme.titleMedium),
                      Text(description, style: theme.textTheme.bodyMedium),
                    ],
                  ),
                ),
                if (button != null) button!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
