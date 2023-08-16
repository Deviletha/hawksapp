import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

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
            height: 180,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/pr bg.jpg"), fit: BoxFit.fill,),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(120),
                // topLeft: Radius.circular(120),
                // bottomRight: Radius.circular(160)
              ),
              border: Border.all(color: Colors.indigo.shade900)
            ),
            child: Center(
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/avatar.png"), radius: 60,
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
          ProfileRow(icon: Iconsax.user,title:"Athira Av",),
          ProfileRow(icon: Iconsax.designtools,title:"Full Stack Developer",),
          ProfileRow(icon: Iconsax.cake,title:"Date of Birth",),
          ProfileRow(icon: Iconsax.sms,title:"athira42@gmail.com",),
          ProfileRow(icon: Iconsax.call,title:"+91 9884556975",),


        ],
      ),
    );
  }
}
