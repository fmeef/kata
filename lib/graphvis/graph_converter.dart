import 'package:kata/src/rust/api/pgp/wot/path.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

Graph convertWotGraph(Graph graph, WotGraph oldgraph) {
  graph.edges.clear();
  graph.nodes.clear();
  graph.addNodes(oldgraph.vertices.keys.map((v) => Node.Id(v)).toList());
  graph.addEdges(
    oldgraph.edges
        .map(
          (v) => Edge(
            graph.getNodeUsingId(v.srcId),
            graph.getNodeUsingId(v.dstId),
          ),
        )
        .toList(),
  );
  return graph;
}

Widget rectangleWidget(String? a) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      boxShadow: [BoxShadow(color: Colors.blue, spreadRadius: 1)],
    ),
    child: Text(a ?? "null"),
  );
}
