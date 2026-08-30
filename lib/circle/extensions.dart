import 'package:flutter/material.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';

extension GetIcon<T extends CircleLike?> on T {
  IconData getIcon() {
    return (switch (this?.getType()) {
      CircleType.user => Icons.person,
      CircleType.circle => Icons.group,
      CircleType.app => Icons.apps,
      null => Icons.device_unknown,
    });
  }
}

extension GetIconCircleOR on CircleOr? {
  IconData getIcon() {
    return (this as CircleLike?).getIcon();
  }
}

extension GetIconCircleEntry on CircleEntry? {
  IconData getIcon() {
    return (this as CircleLike?).getIcon();
  }
}
