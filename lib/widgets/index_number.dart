import 'package:flutter/material.dart';

class IndexNumber extends StatelessWidget {
  const IndexNumber({
    Key? key,
    required this.number,
  }) : super(key: key);
  final int number;
  @override
  Widget build(BuildContext context) {
    return Text(
      (number).toString(),
      style: const TextStyle(
        fontSize: 120,
        fontWeight: FontWeight.w600,
        shadows: [
          Shadow(
            offset: Offset(-1.5, -1.5),
            color: Color(0xFF0296E5),
          ),
          Shadow(
            offset: Offset(1.5, -1.5),
            color: Color(0xFF0296E5),
          ),
          Shadow(
            offset: Offset(1.5, 1.5),
            color: Color(0xFF0296E5),
          ),
          Shadow(
            offset: Offset(-1.5, 1.5),
            color: Color(0xFF0296E5),
          ),
        ],
        color: Color(0xFF242A32),
      ),
    );
  }
}
