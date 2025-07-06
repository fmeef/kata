import 'package:flutter/material.dart';

class GraphItem extends StatelessWidget {
  final String? text;
  const GraphItem({super.key, this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: [BoxShadow(color: Colors.blue, spreadRadius: 1)],
      ),
      child: Text(text ?? "null"),
    );
  }
}
