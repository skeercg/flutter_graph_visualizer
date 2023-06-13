import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'graph_model.dart';
import 'graph_painter.dart';
import 'theme.dart';

class Graph extends StatelessWidget {
  const Graph({super.key});

  @override
  Widget build(BuildContext context) => Consumer<GraphModel>(
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
