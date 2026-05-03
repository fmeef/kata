import 'package:flutter/material.dart';
import 'package:kata/src/rust/api/pgp/fingerprint/visual_key.dart';

class _AutomiconState extends State<Automicon> {
  Image? _small;
  Image? _large;
  BigInt size = BigInt.from(8);
  bool expanded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.handle
          .identiconAutoSize(count: widget.count, scale: widget.scale)
          .getIdenticon()
          .then((v) {
            if (mounted) {
              setState(() {
                if (v != null) {
                  _small = Image.memory(v.buf);
                }
              });
            }
          });
    });
  }

  Future<void> toggleSize() async {
    if (expanded) {
      setState(() {
        expanded = false;
      });
    } else {
      final image = await widget.handle
          .identiconAutoEnd(scale: widget.scale)
          .getIdenticon();
      if (image != null) {
        _large = Image.memory(image.buf);
        setState(() {
          expanded = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_small == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return InkWell(
        onTap: () async => await toggleSize(),
        child: AnimatedCrossFade(
          firstChild: _small!,
          secondChild: _large ?? Center(child: CircularProgressIndicator()),
          crossFadeState: expanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 100),
          reverseDuration: const Duration(milliseconds: 100),
        ),
      );
    }
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
    this.scale = 3,
    this.count = 3,
  });
  @override
  State<StatefulWidget> createState() => _AutomiconState();
}
