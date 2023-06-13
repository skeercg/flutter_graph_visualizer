import 'dart:collection';

import 'package:flutter/widgets.dart';

import 'edge.dart';

class GraphModel extends ChangeNotifier {
  final _edges = <Edge>[];

  UnmodifiableListView<Edge> get edges => UnmodifiableListView<Edge>(_edges);

  void setEdges(List<Edge> edges) {
    _edges
      ..clear()
      ..addAll(edges);
    notifyListeners();
  }
}
