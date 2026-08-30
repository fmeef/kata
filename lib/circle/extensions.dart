import 'package:flutter/material.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';

// extension GetIcon<T extends CircleLike> on T? {
//   IconData getIcon() {
//     return (switch (this?.getType()) {
//       CircleType.user => Icons.person,
//       CircleType.circle => Icons.group,
//       CircleType.app => Icons.apps,
//       null => Icons.device_unknown,
//     });
//   }
// }

extension GetIconCircleOrUse on CircleOr_User? {
  IconData getIcon() {
        return (switch (this?.getType()) {
      CircleType.user => Icons.person,
      CircleType.circle => Icons.group,
      CircleType.app => Icons.apps,
      null => Icons.device_unknown,
    });
  }
}

extension GetIconCircleEntry on CircleEntry? {
  IconData getIcon() {
        return this?.content.getIcon() ?? Icons.device_unknown;
  }
}


extension GetIconCircleOr on CircleOr? {
  IconData getIcon() {
  return (switch (this?.getType()) {
      CircleType.user => Icons.person,
      CircleType.circle => Icons.group,
      CircleType.app => Icons.apps,
      null => Icons.device_unknown,
    });
  }
}