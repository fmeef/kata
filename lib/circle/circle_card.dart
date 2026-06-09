import 'package:flutter/material.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';
import 'package:kata/src/rust/api/pgp/circles/circle.dart';

class _CircleCardState extends State<CircleCard> {
  List<CircleEntry> _members = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.circle.consumeMembers().then(
        (members) => setState(() {
          _members = members;
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const Text('Circle'),
          Column(
            children: _members
                .map((v) => Text('Circle ${v.id.name()}'))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class CircleCard extends StatefulWidget {
  final Circle circle;
  const CircleCard({super.key, required this.circle});

  @override
  State<StatefulWidget> createState() => _CircleCardState();
}
