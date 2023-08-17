import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/colors.dart';
import 'admin_bottomsheet.dart';

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
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left), onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => AdminBottomSheet()));
        },
        ),
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
          border: Border.all(color: Color(ColorT.PrimaryColor),),
          borderRadius: BorderRadius.all(Radius.circular(15)),
          image: DecorationImage(
              image: AssetImage("assets/module bg.jpeg"), fit: BoxFit.fill),
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
