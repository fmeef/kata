import 'package:kata/graphvis/rust_converter.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/db/connection.dart';
import 'package:kata/src/rust/api/pgp/wot/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_graph_view/flutter_graph_view.dart';
import 'package:provider/provider.dart';

class _GraphTestState extends State<GraphTest> {
  var graph = WotGraph(edges: {}, vertices: {}, trust: BigInt.from(0));
  Watcher? watcher;

  @override
  void initState() {
    super.initState();
    final PgpApp app = context.read();
    final w = app.getDb().getWatcher();
    w.watch(
      table: "certs",
      cb: (db) async {
        final network = app.unrootedNetwork();

        final g = await network.dumpAll();
        setState(() {
          graph = g;
        });
      },
    );
    watcher = w;
  }

  @override
  void dispose() {
    super.dispose();
    final w = watcher;
    watcher = null;
    w?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterGraphWidget(
      data: graph,
      convertor: RustConverter(),
      algorithm: CircleLayout(),
      options: Options()
        ..enableHit = false
        ..panelDelay = const Duration(milliseconds: 500)
        ..backgroundBuilder = (ctx) {
          return Container(color: Colors.black);
        }
        ..graphStyle =
            (GraphStyle()
            // tagColor is prior to tagColorByIndex. use vertex.tags to get color
            )
        ..edgeShape =
            EdgeLineShape() // default is EdgeLineShape.
        ..vertexShape = VertexCircleShape(), // default is VertexCircleShape.,
    );
  }
}

class GraphTest extends StatefulWidget {
  const GraphTest({super.key});

  @override
  State<StatefulWidget> createState() => _GraphTestState();
}
