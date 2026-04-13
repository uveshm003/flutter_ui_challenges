import 'package:flutter/material.dart';

class ChallengeOne extends StatelessWidget {
  const ChallengeOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/sign_up_bg.png'), fit: BoxFit.fill),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 50),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 80, height: 80, child: CustomPaint(painter: MyCustomPainter())),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 10),
                    child: Text('lock.data', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                  Text('PROTECT YOUR DATA WITH US.', style: TextStyle(color: Colors.white, fontSize: 56)),
                  SizedBox(height: 10),
                  Text.rich(
                    TextSpan(
                      text: '230,100.04 ',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: 'People trust us!',
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hint: Text('Email address', style: TextStyle(color: Color(0XFF533EDE), fontSize: 20)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0XFFDADADA)),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                      ),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hint: Text('Password', style: TextStyle(color: Color(0XFF533EDE), fontSize: 20)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0XFFDADADA)),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  final Color blue = Color(0XFF2A199D);
  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()
      ..color = Color(0XFF402BD1)
      ..strokeWidth = 1.0;
    final topShape = Paint()
      ..color = blue
      ..strokeWidth = 1.0;
    final newPaint = Paint()
      ..color = Color(0XFFF8F5F0)
      ..strokeWidth = 1.0;
    final firstPath = Path();
    firstPath.moveTo(0, 0);
    firstPath.lineTo(20, 0);
    firstPath.lineTo(0, 20);
    firstPath.lineTo(0, 0);
    final secondPath = Path();
    secondPath.moveTo(20, 0);
    secondPath.lineTo(0, 20);
    secondPath.lineTo(20, 20);
    secondPath.lineTo(20, 0);
    final thirdPath = Path();
    thirdPath.moveTo(20, 0);
    thirdPath.lineTo(60, 0);
    thirdPath.lineTo(60, 80);
    thirdPath.lineTo(0, 80);
    thirdPath.lineTo(0, 20);
    thirdPath.lineTo(20, 20);
    final fourthPath = Path();
    fourthPath.moveTo(0, 0);
    fourthPath.addOval(Rect.fromCenter(center: Offset(30, 40), width: 14, height: 14));
    canvas.drawPath(firstPath, backgroundPaint);
    canvas.drawPath(thirdPath, newPaint);
    canvas.drawPath(secondPath, topShape);
    canvas.drawPath(fourthPath, topShape);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
