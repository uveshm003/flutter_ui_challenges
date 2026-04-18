import 'package:flutter/material.dart';

class ChallengeFour extends StatelessWidget {
  const ChallengeFour({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0XFF23A9FF), Color(0XFF014DFF)],
            begin: AlignmentGeometry.topCenter,
            end: AlignmentGeometry.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height, width: MediaQuery.sizeOf(context).width),
            Positioned(
              right: -30,
              left: -30,
              top: -100,
              bottom: MediaQuery.heightOf(context) * 0.6,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0XFF073BFF),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(MediaQuery.widthOf(context) * 0.5),
                    bottomRight: Radius.circular(MediaQuery.widthOf(context) * 0.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
