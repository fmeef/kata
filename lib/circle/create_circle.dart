import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kata/circle/circle_card.dart';
import 'package:kata/circle/circle_list_options.dart';
import 'package:kata/fab_observer.dart';
import 'package:kata/fab_state.dart';
import 'package:kata/pgp/cert/user_selector.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/pgp.dart';
import 'package:kata/src/rust/api/pgp/circles.dart';
import 'package:kata/src/rust/api/pgp/circles/circle.dart';
import 'package:provider/provider.dart';

class _CreateAppState extends State<CreateCircle> {
  UserHandle? _circleId;
  Circle? _circle;
  late final FabState state = context.read();

  late final FabObserver observer = FabObserver(
    handler: () async {
      final PgpApp pgpApp = context.read();
      await _circle?.toDb(db: pgpApp.getDb());
      if (mounted) context.go('/circles', extra: CircleListOptions());
    },
  );

  @override
  void initState() {
    super.initState();
    state.addHandler(observer);
  }

  @override
  void dispose() {
    super.dispose();
    state.removeHandler(observer);
  }

  @override
  Widget build(BuildContext context) {
    final PgpApp pgpApp = context.read();
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              if (_circle != null)
                Flexible(
                  flex: 2,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CircleCard(
                              members: _circle!,
                              id: _circleId!,
                              constrained: BoxConstraints(maxHeight: 250),
                              expanded: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              Expanded(
                flex: 3,
                child: UserSelector(
                  selected: (l) async {
                    final c = await pgpApp.createCircle(
                      keys: l
                          .map(
                            (v) =>
                                CircleOr.fromCert(userHandle: v.fingerprint()),
                          )
                          .toList(),
                    );

                    final id = c.getIdUserhandle();

                    setState(() {
                      _circle = c;
                      _circleId = id;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CreateCircle extends StatefulWidget {
  const CreateCircle({super.key});

  @override
  State<StatefulWidget> createState() => _CreateAppState();
}
