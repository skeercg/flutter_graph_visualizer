class Edge {
  final int? x;
  final int? y;

  const Edge(this.x, this.y);

  @override
  String toString() => '$x -> $y';
}

enum GraphType {
  undirected('Undirected'),
  directed('Directed');

  final String label;

  const GraphType(this.label);
}
