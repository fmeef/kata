import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kata/pgp/cert/automicon_image_stream_completer.dart';
import 'package:kata/src/rust/api/pgp.dart';
import 'package:flutter/painting.dart';

class AutomiconImageProvider extends ImageProvider<UserHandle> {
  final UserHandle userHandle;
  final int scale;

  AutomiconImageProvider({required this.userHandle, this.scale = 16});

  @override
  Future<UserHandle> obtainKey(ImageConfiguration configuration) async {
    return userHandle;
  }

  @override
  ImageStreamCompleter loadImage(UserHandle key, ImageDecoderCallback decode) {
    final AutomiconImageStreamCompleter completer =
        AutomiconImageStreamCompleter();

    key
        .identicon(scale: scale)
        .then(
          (img) async => await ImageDescriptor.raw(
            await ImmutableBuffer.fromUint8List(img.buf),
            width: img.width,
            height: img.height,
            pixelFormat: PixelFormat.bgra8888,
          ).instantiateCodec(),
        );

    return completer;
  }
}
