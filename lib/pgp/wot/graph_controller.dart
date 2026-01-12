import 'package:kata/src/rust/api/pgp/cert.dart';
import 'package:kata/src/rust/api/pgp/wot/path.dart';

class GraphController {
  final WotGraph graph;
  final PgpCertWithIds target;
  GraphController({required this.graph, required this.target}) {
    refresh();
  }

  void refresh() {
    // algorithm.nodeRects.clear();
    // algorithm.displacement.clear();

    //   algorithm.init(graph);
    //    graph.notifyGraphObserver();
  }
}
