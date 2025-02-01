import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

@override
State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
int selectindex=0;

@override
Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            
            bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: selectindex,
            onTap: (index){
            selectindex=index;
            setState(() {
            });
            }, items: [ 
                BottomNavigationBarItem(icon:SvgPicture.asset("assets/Svg/Home 1.svg"),
                label: "home"),
                BottomNavigationBarItem(icon:SvgPicture.asset("assets/Svg/Vector.svg"),label: "maps",
                activeIcon: Container(
                    
                    child: SvgPicture.asset("assets/Svg/Vector.svg",colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn) ,))),
                BottomNavigationBarItem(icon:SvgPicture.asset("assets/Svg/Vector.svg"),label: "maps"),

            ],
            
),    
    ));
}
}