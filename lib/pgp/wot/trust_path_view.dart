import 'package:kata/graphvis/rust_converter.dart';
import 'package:kata/pgp/wot/graph_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_graph_view/flutter_graph_view.dart';

class TrustPathView extends StatelessWidget {
  final GraphController adapter;
  const TrustPathView({super.key, required this.adapter});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          'Trust path for ${adapter.target.ids.first} size=${adapter.graph.vertices.length}',
          style: theme.textTheme.titleSmall,
        ),
        // Expanded(
        //   child: GraphView.builder(
        //     graph: adapter.graph,
        //     algorithm: adapter.algorithm,
        //     centerGraph: false,
        //     autoZoomToFit: true,
        //     builder: (node) => GraphItem(text: node.key!.value as String?),
        //   ),
        // ),
        Expanded(
          child: FlutterGraphWidget(
            data: adapter.graph,
            convertor: RustConverter(),
            algorithm: CircleLayout(),
            options: Options()
              ..enableHit = true
              ..scaleRange = Vector2(0.0001, 5)
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
              ..vertexShape = VertexCircleShape(),
          ),
        ),
      ],
    );
  }
}
