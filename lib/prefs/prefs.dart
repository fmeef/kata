import 'package:kata/prefs/keyserver_list.dart';
import 'package:kata/prefs/prefs_item.dart';
import 'package:flutter/material.dart';
import 'package:kata/prefs/text_input_dialog.dart';
import 'package:kata/src/rust/api.dart';
import 'package:provider/provider.dart';

class _PrefsViewState extends State<Prefs> {
  BigInt? databaseVersion;

  @override
  void initState() {
    final PgpApp pgpApp = context.read();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pgpApp.getDb().getMigrationVersion().then(
        (v) => setState(() {
          databaseVersion = v;
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final PgpApp pgpApp = context.read();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrefsItem(
          description: "List of keyservers to connect to",
          title: "Keyserver list",
          onTap: () async => await showDialog(
            context: context,
            builder: (ctx) => Dialog(child: KeyserverList()),
          ),
        ),
        PrefsItem(
          description: 'Migrate the database manually',
          title: 'Database version',
          button: Text(databaseVersion?.toString() ?? ""),
          onTap: () async => await showDialog(
            context: context,
            builder: (ctx) => Dialog(
              child: TextInputDialog(
                onText: (t) async {
                  if (t != null) {
                    final version = BigInt.tryParse(t);
                    if (version != null) {
                      await pgpApp.getDb().rollback(version: version);
                    }
                  }
                },
              ),
            ),
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
