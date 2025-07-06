import 'package:kata/prefs/keyserver_list_item.dart';
import 'package:kata/prefs/pref_keys.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _KeyserverListState extends State<KeyserverList> {
  final keyserverController = TextEditingController();
  List<String> keyservers = [];
  final scrollController = ScrollController();
  final GlobalKey<FormState> _formState = GlobalKey();

  @override
  void initState() {
    super.initState();
    final SharedPreferencesAsync prefs = context.read();
    prefs
        .getStringList(prefKeyserverList)
        .then(
          (v) => setState(() {
            keyservers = v ?? [];
          }),
        );
  }

  Future<void> updateTexts() async {
    final SharedPreferencesAsync prefs = context.read();
    if (_formState.currentState!.validate()) {
      final texts = await prefs.getStringList(prefKeyserverList) ?? [];
      texts.add(keyserverController.text);
      await prefs.setStringList(prefKeyserverList, texts);
      await scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
      if (context.mounted) {
        setState(() {
          keyservers = texts;
          keyserverController.clear();
        });
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: const Text('Invalid keyserver url')));
    }
  }

  Future<void> removeTexts(String v) async {
    final SharedPreferencesAsync prefs = context.read();
    final texts = await prefs.getStringList(prefKeyserverList) ?? [];
    texts.remove(v);
    await prefs.setStringList(prefKeyserverList, texts);
    setState(() {
      keyservers = texts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Current keyservers'),
            SizedBox(
              height: 200,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                controller: scrollController,
                children: keyservers
                    .map(
                      (v) => KeyserverListItem(
                        keyserver: v,
                        onDelete: (v) async => await removeTexts(v),
                      ),
                    )
                    .toList(),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Form(
                    key: _formState,
                    child: TextFormField(
                      validator: (v) {
                        if (v == null) {
                          return 'Missing url';
                        }
                        try {
                          if (!Uri.parse(v).isAbsolute) {
                            return 'Invalid url';
                          }
                          return null;
                        } on Exception {
                          return 'Invalid url';
                        }
                      },
                      controller: keyserverController,
                      onEditingComplete: () async => await updateTexts(),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async => await updateTexts(),
                  child: const Text('Add'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class KeyserverList extends StatefulWidget {
  const KeyserverList({super.key});

  @override
  State<StatefulWidget> createState() => _KeyserverListState();
}
