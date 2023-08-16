import 'package:flutter/material.dart';
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
        itemBuilder: (context, index) => services(index),
      ),
    );
  }
  Widget services (int index) {
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
            border: Border.all(color: Colors.indigo.shade700,),
            borderRadius: BorderRadius.all(Radius.circular(15)),
            image: DecorationImage(
                image: AssetImage("assets/bg 1.jpg"), fit: BoxFit.fill),
          ),
          child: Center(
            child: Text("Projects Title",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
          ),
        ),
      ),
    );
  }
}
