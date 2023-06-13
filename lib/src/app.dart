import 'package:flutter/material.dart';

import 'graph_editor_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: GraphEditorScreen(),
      );
}
