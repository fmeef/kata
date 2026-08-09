import 'package:kata/circle/circle_delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:kata/circle/circle_selector.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';

class _CircleCardMenuState extends State<CircleCardMenu> {
  final FocusNode _buttonFocusNode = FocusNode(debugLabel: 'Menu');
  final MenuController _controller = MenuController();

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      controller: _controller,
      menuChildren: [
        MenuItemButton(
          child: const Text('delete'),
          onPressed: () async => await showDialog(
            context: context,
            builder: (ctx) =>
                CircleDeleteDialog(circle: widget.circle, context: context),
          ),
        ),
        MenuItemButton(
          child: const Text('Add to circle'),
          onPressed: () async => showModalBottomSheet(
            context: context,
            builder: (ctx) => CircleSelector(selected: (sel) => ()),
          ),
        ),
      ],
      builder: (ctx, controller, child) => IconButton(
        focusNode: _buttonFocusNode,
        onPressed: () {
          if (controller.isOpen) {
            controller.close();
          } else {
            controller.open();
          }
        },
        icon: Icon(Icons.menu),
      ),
    );
  }
}

class CircleCardMenu extends StatefulWidget {
  final CircleOr circle;

  const CircleCardMenu({super.key, required this.circle});

  @override
  State<StatefulWidget> createState() => _CircleCardMenuState();
}
