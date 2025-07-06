import 'package:kata/graphvis/graph_converter.dart';
import 'package:kata/graphvis/graph_item.dart';
import 'package:kata/src/rust/api.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:provider/provider.dart';

class DisplayGraph extends StatelessWidget {
  DisplayGraph({super.key});

  final graph = Graph();
  final FruchtermanReingoldAlgorithm algorithm = FruchtermanReingoldAlgorithm(
    FruchtermanReingoldConfiguration()..iterations = 1000,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () async {
            if (context.mounted) {
              PgpApp serv = context.read();
              final network = serv.unrootedNetwork();

              convertWotGraph(graph, await network.dumpAll());

              /// This really should be documented more
              algorithm.nodeRects.clear();
              algorithm.displacement.clear();
              algorithm.init(graph);
              graph.notifyGraphObserver();
            }
          },
          child: const Text('Refresh'),
        ),

        Expanded(
          child: InteractiveViewer(
            constrained: false,
            boundaryMargin: EdgeInsets.all(8),
            minScale: 0.001,
            maxScale: 10000,
            child: GraphViewCustomPainter(
              graph: graph,
              paint: Paint()
                ..color = Colors.green
                ..strokeWidth = 1
                ..style = PaintingStyle.fill,
              algorithm: algorithm,
              builder: (node) => GraphItem(text: node.key!.value as String?),
            ),
          ),
        ),
      ],
    );
  }
}
