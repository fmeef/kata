import 'package:flutter_graph_view/flutter_graph_view.dart';

class CenterSpecificDecoder extends GraphAlgorithm {
  final String? specificNodeId;

  CenterSpecificDecoder({this.specificNodeId});

  @override
  void compute(Vertex v, Graph graph) {
    super.compute(v, graph);
    if (pinCenter(v)) {
      //   v.position = (v.?.game.size ?? Vector2.zero()) / 2;
    }
  }

  bool pinCenter(Vertex v) {
    return specificNodeId == v.id;
  }
}
