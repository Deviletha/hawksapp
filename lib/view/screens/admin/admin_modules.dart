import 'package:flutter/material.dart';

class AdModules extends StatefulWidget {
  const AdModules({Key? key}) : super(key: key);

  @override
  State<AdModules> createState() => _AdModulesState();
}

class _AdModulesState extends State<AdModules> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modules"),
      ),
      body: ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) => subServices(index),
      ),
    );
  }
  Widget subServices (int index) {
    return   Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.indigo.shade700,),
          borderRadius: BorderRadius.all(Radius.circular(15)),
          image: DecorationImage(
              image: AssetImage("assets/bg3.jpg"), fit: BoxFit.fill),
        ),
        child: Center(
          child: Text("Modules",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
        ),
      ),
    );
  }
}
