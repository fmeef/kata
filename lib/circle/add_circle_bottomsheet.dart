import 'package:flutter/material.dart';
import 'package:kata/circle/circle_selector.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';

class AddCircleBottomsheet extends StatelessWidget {
  final CircleHandle? parent;
  const AddCircleBottomsheet({super.key, this.parent});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CircleSelector(parent: parent, selected: (sel) => ()),
        ),
        Row(
          children: [
            ElevatedButton(onPressed: () => (), child: const Text('Add')),
          ],
        ),
      ],
    );
  }
}
