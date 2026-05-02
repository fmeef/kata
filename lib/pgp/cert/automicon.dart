import 'package:flutter/material.dart';
import 'package:kata/src/rust/api/pgp/fingerprint/visual_key.dart';

class _AutomiconState extends State<Automicon> {
  Image? _image;
  BigInt size = BigInt.from(8);
  bool expanded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.handle
          .identiconAutoSize(count: widget.count, scale: 3)
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

  Future<void> toggleSize() async {
    if (expanded) {
      final image = await widget.handle
          .identiconAutoSize(count: widget.count, scale: widget.scale)
          .getIdenticon();
      if (image != null) {
        setState(() {
          expanded = false;
          _image = Image.memory(image.buf);
        });
      }
    } else {
      final image = await widget.handle
          .identiconAutoEnd(scale: 3)
          .getIdenticon();
      if (image != null) {
        setState(() {
          expanded = true;
          _image = Image.memory(image.buf);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => await toggleSize(),
      child: _image ?? Center(child: CircularProgressIndicator()),
    );
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
