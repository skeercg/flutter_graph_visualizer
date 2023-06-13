import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme.dart';
import 'graph.dart';
import 'graph_data.dart';
import 'graph_model.dart';

class GraphEditorScreen extends StatelessWidget {
  const GraphEditorScreen({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GraphModel(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primary,
          ),
          body: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GraphData(),
                SizedBox(width: 30),
                Graph(),
              ],
            ),
          ),
        ),
      );
}
