
import 'package:evently/create_event.dart';
import 'package:evently/tabs/home/home.dart';
import 'package:evently/tabs/love/love.dart';
import 'package:evently/tabs/maps/maps.dart';
import 'package:evently/tabs/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

@override
State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
int selectindex=0;
List<Widget>tabs=[
  const Home(),
  const Maps(),
  const Love(),
  const Profile()
];
@override
Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: tabs[selectindex],
        ),
          floatingActionButton:FloatingActionButton(onPressed:()=>Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const CreateEvent())),
          child: const Icon(Icons.add,size: 30,),),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            padding: EdgeInsets.zero,
            notchMargin: 2,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: const CircularNotchedRectangle(),
            
            child: BottomNavigationBar(
              elevation: 0,
              
              
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
                
                    
                    child: SvgPicture.asset("assets/Svg/Vector.svg",colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn) ,
                    )
                    )
                    ),
                BottomNavigationBarItem(icon:SvgPicture.asset("assets/Svg/Heart.svg"),label: "Love"),
                BottomNavigationBarItem(icon:SvgPicture.asset("assets/Svg/User_01.svg"),label: "Profile"),
            
            ],
            
            ),
          ),    
          ),
    );
}
}