import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'graph_controller.dart';
import 'models.dart';
import 'theme.dart';

class Graph extends StatelessWidget {
  const Graph({super.key});

  @override
  Widget build(BuildContext context) => Consumer<GraphController>(
        builder: (context, graph, child) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.primary),
          ),
          width: 800,
          height: 800,
          child: CustomPaint(
            painter: GraphPainter(graph.edges),
          ),
        ),
      );
}

class GraphPainter extends CustomPainter {
  final List<Edge> edges;

  const GraphPainter(this.edges);

  @override
  void paint(Canvas canvas, Size size) {
    final edgePaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final vertexPaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    final vertices = <int>[];

    for (final edge in edges) {
      if (!vertices.contains(edge.x) && edge.x != null) {
        vertices.add(edge.x!);
      }
      if (!vertices.contains(edge.y) && edge.y != null) {
        vertices.add(edge.y!);
      }
    }

    final coordinates = calculatePolygonVertices(
      vertices,
      Offset(size.width / 2, size.height / 2),
      size.width / 3,
      vertices.length,
    );

    for (final vertex in vertices) {
      canvas.drawCircle(coordinates[vertex]!, 20, vertexPaint);
    }

    final path = Path();

    for (var i = 0; i < edges.length; i++) {
      final x = edges[i].x;
      final y = edges[i].y;

      if (x == null || y == null) continue;

      path
        ..moveTo(coordinates[x]!.dx, coordinates[x]!.dy)
        ..lineTo(coordinates[y]!.dx, coordinates[y]!.dy);
    }

    canvas.drawPath(path, edgePaint);

    for (final vertex in vertices) {
      final textSpan = TextSpan(
        text: vertex.toString(),
        style: AppFonts.font18,
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      )..layout();

      final textOffset = Offset(
        coordinates[vertex]!.dx - textPainter.width / 2,
        coordinates[vertex]!.dy - textPainter.height / 2,
      );

      textPainter.paint(canvas, textOffset);
    }
  }

  @override
  bool shouldRepaint(covariant GraphPainter oldDelegate) =>
      oldDelegate.edges != edges;

  Map<int, Offset> calculatePolygonVertices(
      List<int> vertices, Offset center, double radius, int n) {
    final coordinates = <int, Offset>{};
    final angle = 2 * pi / n;

    for (var i = 0; i < n; i++) {
      final theta = i * angle;
      final x = center.dx + radius * cos(theta);
      final y = center.dy + radius * sin(theta);
      coordinates.putIfAbsent(vertices[i], () => Offset(x, y));
    }

    return coordinates;
  }
}
