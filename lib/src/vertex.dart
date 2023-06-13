import 'package:flutter/material.dart';

import 'theme.dart';

class VertexBubble extends StatelessWidget {
  const VertexBubble({required this.value, super.key});

  final int value;

  @override
  Widget build(BuildContext context) => Draggable(
        feedback: const SizedBox.shrink(),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: Text(
            value.toString(),
          ),
        ),
      );
}
