
import 'package:firebase_app/config/themes/app_colors.dart';
import 'package:flutter/material.dart';

class BackgroundDecorationWidget extends StatelessWidget {
  const BackgroundDecorationWidget(
      {Key? key, required this.child, this.showGradient = false})
      : super(key: key);
  final Widget child;
  final bool showGradient;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Container(
          decoration: BoxDecoration(
            color: showGradient ? null : Theme.of(context).primaryColor,
            gradient: showGradient ? mainGradientLight : null,
          ),
              child: CustomPaint(
                painter: BackgroundPainter(),
              ),
        ),
        ),
        Positioned.fill(child: SafeArea(child: child)),
      ],
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white.withOpacity(0.1);
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width*0.2, 0);
    path.lineTo(0, size.height*0.4);
    path.close();
    final path1 = Path();
    path1.moveTo(size.width, 0);
    path1.lineTo(size.width*0.8, 0);
    path1.lineTo(size.width*0.2, size.height);
    path1.lineTo(size.width, size.height);
    path1.close();
    canvas.drawPath(path, paint);
    canvas.drawPath(path1, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
