import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChallengeTwo extends StatelessWidget {
  const ChallengeTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF101112),
      appBar: AppBar(
        backgroundColor: Color(0XFF101112),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(height: 16, width: 16, padding: const EdgeInsets.only(left: 20), child: SvgPicture.asset('assets/svgs/icon_back.svg')),
        ),
        title: Text('Checkout', style: TextStyle(color: Colors.white, fontSize: 26)),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(padding: const EdgeInsets.only(right: 40), child: SvgPicture.asset('assets/svgs/icon_menu.svg')),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(width: double.maxFinite, height: 30),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Image.asset('assets/images/card.png', width: double.maxFinite, fit: BoxFit.fill),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Purchase', style: TextStyle(color: Colors.white, fontSize: 26)),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset('assets/svgs/icon_menu.svg'),
                ),
              ],
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraint) {
                return Stack(
                  children: [
                    Container(width: double.maxFinite, height: constraint.maxHeight, color: Colors.transparent),
                    Positioned.fill(
                      top: 80,
                      child: SafeArea(
                        child: Container(
                          width: double.maxFinite,
                          height: constraint.maxHeight,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                          ),
                        ),
                      ),
                    ),
                    Positioned(child: Image.asset('assets/images/shoes.png')),
                    Positioned(
                      right: 30,
                      left: 30,
                      bottom: 14,
                      child: SafeArea(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Men's Shoe", style: TextStyle(color: Color(0XFFA0A7BA), fontSize: 20)),
                                Text(
                                  "Nike Shoe",
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 38),
                                ),
                                Text(
                                  "\$ 320.99",
                                  style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(colors: [Color(0XFFD40C3D), Color(0XFFFF602C)]),
                                ),
                                child: Center(child: Icon(Icons.arrow_forward, color: Colors.white, size: 34)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
