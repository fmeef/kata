import 'package:kata/graphvis/db_graph_observer.dart';
import 'package:kata/src/rust/api/pgp/wot/path.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class GraphAdapter extends Graph {
  final WotGraph graph;
  final Graph overlay = Graph();

  final observer = DbGraphObserver();

  GraphAdapter({required this.graph});

  @override
  List<Node> get nodes => graph.vertices.keys.map((v) => Node.Id(v)).toList();

  @override
  List<Edge> get edges => graph.edges
      .map((v) => Edge(getNodeUsingId(v.srcId), getNodeUsingId(v.dstId)))
      .followedBy(overlay.edges)
      .toList();

  @override
  Edge addEdge(Node source, Node destination, {Paint? paint}) {
    graph.edges.add(
      GraphEdge(
        srcId: source.key!.value! as String,
        dstId: destination.key!.value! as String,
        edgeName: "",
        ranking: 0,
      ),
    );

    return Edge(source, destination);
  }

  @override
  Node getNodeUsingId(id) {
    return Node.Id(graph.vertices[id]!.id);
  }

  @override
  List<Edge> getInEdges(Node node) {
    return graph.edges
        .where((e) => e.dstId == node.key!.value! as String)
        .map((e) => Edge(getNodeUsingId(e.srcId), getNodeUsingId(e.dstId)))
        .toList();
  }
}
