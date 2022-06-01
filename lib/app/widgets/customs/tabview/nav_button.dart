import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  final double position;
  final int length;
  final int index;

  const NavButton({
    required this.position,
    required this.length,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final desiredPosition = 1.0 / length * index;
    final difference = (position - desiredPosition).abs();
    final verticalAlignment = 1 - length * difference;
    final opacity = length * difference;
    return Expanded(
      child: SizedBox(
        height: 75.0,
        child: Transform.translate(
          offset: Offset(
            0,
            difference < 1.0 / length ? verticalAlignment * 40 : 0,
          ),
          child: Opacity(
            opacity: difference < 1.0 / length * 0.99 ? opacity : 1.0,
          ),
        ),
      ),
    );
  }
}
