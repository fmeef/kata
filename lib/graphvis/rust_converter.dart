import 'package:kata/src/rust/api/pgp/wot/path.dart';
import 'package:flutter_graph_view/flutter_graph_view.dart';

class RustConverter extends DataConvertor<GraphVertex, GraphEdge> {
  @override
  Edge convertEdge(GraphEdge e, Graph graph) {
    Edge edge = Edge();
    edge.start = graph.keyCache[e.srcId]!;
    edge.end = graph.keyCache[e.dstId];
    edge.ranking = e.ranking;
    edge.edgeName = e.edgeName;
    return edge;
  }

  @override
  Vertex convertVertex(GraphVertex v, Graph graph) {
    Vertex vertex = Vertex();
    vertex.id = v.id;
    vertex.tag = v.tag;
    vertex.tags = v.tags;
    vertex.data = v.data;
    return vertex;
  }

  @override
  Graph convertGraph(data, {Graph? graph}) {
    var result = graph ?? Graph();

    result.data = data;

    if (data is WotGraph) {
      for (GraphVertex vertex in data.vertices.values) {
        addVertex(vertex, result);
      }

      for (GraphEdge edge in data.edges) {
        addEdge(edge, result);
      }
    }
    return result;
  }
}
