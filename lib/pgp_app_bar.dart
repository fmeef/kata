import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class _PgpAppBarState extends State<PgpAppBar> with RouteAware {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      leadingWidth: 128,
      leading: Builder(
        builder: (context) => Row(
          children: [
            IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu),
            ),
            IconButton(
              onPressed: () {
                if (context.canPop()) context.pop();
              },
              icon: Icon(Icons.arrow_back),
            ),
          ],
        ),
      ),
    );
  }
}

class PgpAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  const PgpAppBar({super.key, required this.title});

  @override
  Size get preferredSize => Size.fromHeight(45);

  @override
  State<StatefulWidget> createState() => _PgpAppBarState();
}
