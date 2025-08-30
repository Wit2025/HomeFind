import 'package:flutter/material.dart';

/// คลาสตัดรอยเว้าที่แก้ไขแล้ว
class PositionedOvalClipper extends CustomClipper<Path> {
  final double positionY; // 0.0 (top) to 1.0 (bottom)
  final double radius;

  const PositionedOvalClipper({
    this.positionY = 0.95, // Default near bottom
    this.radius = 20,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    final yPos = size.height * positionY;
    final notchRadius = radius;

    // 1. Draw the top section
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, yPos - notchRadius);

    // 2. Draw the right side indentation (semi-circle cutout)
    path.arcToPoint(
      Offset(size.width, yPos + notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );

    // 3. Draw the bottom section
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, yPos + notchRadius);

    // 4. Draw the left side indentation (semi-circle cutout)
    path.arcToPoint(
      Offset(0, yPos - notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant PositionedOvalClipper oldClipper) =>
      oldClipper.positionY != positionY || oldClipper.radius != radius;
}