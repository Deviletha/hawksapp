import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import 'admin_modules.dart';

class AdProjects extends StatefulWidget {
  const AdProjects({Key? key}) : super(key: key);

  @override
  State<AdProjects> createState() => _AdProjectsState();
}

class _AdProjectsState extends State<AdProjects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Projects"),
      ),
      body: ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) => Modules(index),
      ),
    );
  }
  Widget Modules (int index) {
    return   Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => AdModules()));
        },
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Color(ColorT.PrimaryColor),),
            borderRadius: BorderRadius.all(Radius.circular(15)),
            image: DecorationImage(
                image: AssetImage("assets/project_bg.jpeg"), fit: BoxFit.fill),
          ),
          child: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Projects Title",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                Text("Projects description",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
