import 'package:kata/src/rust/api/pgp/cert.dart';
import 'package:kata/src/rust/api/pgp/wot/path.dart';
import 'package:graphview/GraphView.dart';

class GraphController {
  final algorithm = FruchtermanReingoldAlgorithm(
    FruchtermanReingoldConfiguration()
      ..shuffleNodes = true
      ..repulsionPercentage = 3
      ..repulsionRate = 0.3
      ..attractionRate = 1.2
      ..attractionPercentage = 1
      ..clusterPadding = 20,
    renderer: ArrowEdgeRenderer(),
  );
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
