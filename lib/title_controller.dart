import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TitleWithArgs {
  final String? title;
  final Object? args;
  const TitleWithArgs({required this.title, required this.args});

  @override
  int get hashCode => title.hashCode % args.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is TitleWithArgs) {
      return other.title == title && other.args == args;
    } else {
      return other == this;
    }
  }
}

class TitleController {
  String title;
  final Map<TitleWithArgs, String> _altTitle = {};
  TitleController({required this.title});

  String getTitle({required String title, required Object? args}) {
    return _altTitle[TitleWithArgs(title: title, args: args)] ?? this.title;
  }

  void push({
    required String? title,
    required String alt,
    required Object? args,
  }) {
    _altTitle[TitleWithArgs(title: title, args: args)] = alt;
  }

  void pop({required String? title, required Object? args}) {
    _altTitle.remove(TitleWithArgs(title: title, args: args));
  }
}

extension TitleHelpers on BuildContext {
  Future<Object?> pushAlt({required String path, dynamic extra, String? alt}) {
    if (alt == null) {
      return push(path, extra: extra);
    } else {
      final TitleController controller = read();
      controller.push(title: path, alt: alt, args: extra);
      return push(path, extra: extra);
    }
  }
}

String titleFromPath(String path) {
  return switch (path) {
    '/' => 'My Cards',
    '/generate' => 'Generate identity',
    '/sign_data' => 'Full network',
    '/network' => 'Full network',
    '/sign' => "Add trust to a friend's card",
    '/list' => 'All Cards',
    '/share' => 'Sharing identity card',
    '/mycards' => 'My Cards',
    '/newapp' => 'Create App',
    '/newcircle' => 'Create Circle',
    '/circles' => 'Circles and Apps',
    _ => 'Kata',
  };
}
