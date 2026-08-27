import 'package:flutter/material.dart';
import 'package:kata/circle/member_entry.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';
import 'package:provider/provider.dart';

class _MiniCircleState extends State<MiniCircle> {
  CircleOr? _child;

  @override
  void initState() {
    super.initState();
    PgpApp pgpApp = context.read();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final members = await pgpApp.getCircleById(id: widget.handle);
      if (mounted && _child == null) {
        setState(() {
          _child = members;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.cardColor,
      child: Padding(
        padding: EdgeInsetsGeometry.fromSTEB(16, 8, 16, 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    <Widget>[
                      Text(
                        _child?.getIdUserhandle().separateLujvo().joinGismu() ??
                            "",
                      ),
                    ] +
                    (_child
                            ?.getMembers()
                            .map((v) => MemberEntry(entry: v))
                            .toList() ??
                        []),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MiniCircle extends StatefulWidget {
  final CircleHandle handle;
  final Color? cardColor;
  const MiniCircle({super.key, required this.handle, this.cardColor});

  @override
  State<StatefulWidget> createState() => _MiniCircleState();
}
