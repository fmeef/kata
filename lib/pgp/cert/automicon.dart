import 'package:flutter/material.dart';
import 'package:kata/src/rust/api/pgp/fingerprint/visual_key.dart';

class _AutomiconState extends State<Automicon> {
  Image? _image;
  BigInt size = BigInt.from(8);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.handle
          .identicon(
            start: widget.len - size,
            end: widget.len,
            count: widget.count,
            scale: widget.scale,
          )
          .getIdenticon()
          .then((v) {
            if (mounted) {
              setState(() {
                if (v != null) {
                  _image = Image.memory(v.buf);
                }
              });
            }
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(child: _image ?? Center(child: CircularProgressIndicator()));
  }
}

class Automicon extends StatefulWidget {
  final VisualKeyBuilder handle;
  final BigInt len;
  final int scale;
  final int count;
  const Automicon({
    super.key,
    required this.handle,
    required this.len,
    this.scale = 8,
    this.count = 3,
  });
  @override
  State<StatefulWidget> createState() => _AutomiconState();
}
