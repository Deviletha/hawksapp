import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../theme/colors.dart';
import '../../widgets/profilewidget.dart';

class EmplProfile extends StatefulWidget {
  const EmplProfile({Key? key}) : super(key: key);

  @override
  State<EmplProfile> createState() => _EmplProfileState();
}

class _EmplProfileState extends State<EmplProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: ListView(
        children: [
          Container(
            height: 110,
            decoration: BoxDecoration(
              // image: DecorationImage(
              //   image: AssetImage("assets/profilebg.jpeg"),fit: BoxFit.fill
              // ),
                color: Color(ColorT.PrimaryColor),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(120),
              ),
            ),
            child: Center(
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/profile avatar.png"), radius: 50,
              ),
            ),
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Divider(
              color: Colors.grey.shade200,thickness: 2,
            ),
          ),
          ProfileRow(icon: Iconsax.user,title:"Arathi AV",),
          ProfileRow(icon: Iconsax.designtools,title:"Full Stack Developer",),
          ProfileRow(icon: Iconsax.cake,title:"Date of Birth",),
          ProfileRow(icon: Iconsax.sms,title:"athira42@gmail.com",),
          ProfileRow(icon: Iconsax.call,title:"+91 9884556975",),
        ],
      ),
    );
  }
}
