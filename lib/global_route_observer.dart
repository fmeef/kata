import 'package:flutter/material.dart';
import 'package:kata/title_controller.dart';

class GlobalRouteObserver extends RouteObserver {
  final TitleController titleController;

  GlobalRouteObserver({required this.titleController});

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    titleController.pop(
      title: route.settings.name,
      args: route.settings.arguments,
    );
  }
}
