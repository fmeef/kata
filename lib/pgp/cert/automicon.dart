import 'package:flutter/material.dart';
import 'package:kata/src/rust/api/pgp.dart';

class _AutomiconState extends State<Automicon> {
  Image? _image;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.handle.identicon(scale: widget.scale, count: widget.count).then((
        v,
      ) {
        setState(() {
          _image = Image.memory(v.buf);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _image ?? Center(child: CircularProgressIndicator());
  }
}

class Automicon extends StatefulWidget {
  final UserHandle handle;
  final int scale;
  final int count;
  const Automicon({
    super.key,
    required this.handle,
    this.scale = 8,
    this.count = 3,
  });
  @override
  State<StatefulWidget> createState() => _AutomiconState();
}
