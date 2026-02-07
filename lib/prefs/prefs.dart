import 'package:kata/prefs/keyserver_list.dart';
import 'package:kata/prefs/prefs_item.dart';
import 'package:flutter/material.dart';

class _PrefsViewState extends State<Prefs> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrefsItem(
          description: "List of keyservers to connect to",
          title: "Keyserver list",
          onTap: () async => await showDialog(
            context: context,
            builder: (ctx) => KeyserverList(),
          ),
        ),
      ],
    );
  }
}

class Prefs extends StatefulWidget {
  const Prefs({super.key});

  @override
  State<StatefulWidget> createState() => _PrefsViewState();
}
