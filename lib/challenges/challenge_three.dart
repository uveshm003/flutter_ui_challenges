import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChallengeThree extends StatelessWidget {
  const ChallengeThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF160C6E),
      body: Stack(
        children: [
          SizedBox(height: MediaQuery.sizeOf(context).height, width: MediaQuery.sizeOf(context).width),
          Positioned(
            right: MediaQuery.sizeOf(context).width * 0.2,
            left: MediaQuery.sizeOf(context).width * 0.2,
            bottom: 0,
            top: 0,
            child: Center(child: Image.asset("assets/images/gear_vr.png")),
          ),
          Positioned(
            left: 30,
            top: 30,
            bottom: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset('assets/svgs/svg_gear_vr.svg'),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gear VR',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 12),
                    Text('Design', style: TextStyle(fontSize: 24, color: Colors.white.withValues(alpha: 0.5))),
                    SizedBox(height: 8),
                    Text('Display', style: TextStyle(fontSize: 24, color: Colors.white.withValues(alpha: 0.5))),
                    SizedBox(height: 8),
                    Text('Experience', style: TextStyle(fontSize: 24, color: Colors.white.withValues(alpha: 0.5))),
                    SizedBox(height: 8),
                    Text('Spec', style: TextStyle(fontSize: 24, color: Colors.white.withValues(alpha: 0.5))),
                    SizedBox(height: 8),
                    Text('Gallery', style: TextStyle(fontSize: 24, color: Colors.white.withValues(alpha: 0.5))),
                  ],
                ),
                Spacer(),
                Row(children: [SvgPicture.asset('assets/svgs/twitter.svg'), SizedBox(width: 10), SvgPicture.asset('assets/svgs/facebook.svg')]),
              ],
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            right: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Spacer(),
                Text(
                  'GEAR VR',
                  style: TextStyle(fontSize: 100, color: Colors.white, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 10),
                Text(
                  """It's easy to get lost in the world of\n virtual reality because the Gear VR\n is engineered to feel lighter.""",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                SizedBox(height: 25),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    gradient: LinearGradient(colors: [Color(0XFFDF387C), Color(0XFFFF602C)]),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 12),
                      child: Row(
                        children: [
                          Text('Find out more', style: TextStyle(fontSize: 16, color: Colors.white)),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
