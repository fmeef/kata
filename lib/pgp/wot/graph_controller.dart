import 'package:kata/src/rust/api/pgp/cert.dart';
import 'package:kata/src/rust/api/pgp/wot/path.dart';

class GraphController {
  final WotGraph graph;
  final PgpCertWithIds target;
  const GraphController({required this.graph, required this.target});
}
