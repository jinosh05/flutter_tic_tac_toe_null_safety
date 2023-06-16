import 'package:flutter/material.dart';

class O extends StatelessWidget {
  final double size;
  final Color color;

  const O(this.size, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        gradient: RadialGradient(
          radius: 0.18,
          colors: [Colors.transparent, color],
          stops: const [1, 1],
        ),
      ),
    );
  }
}
