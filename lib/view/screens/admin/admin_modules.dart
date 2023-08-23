import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../Config/ApiHelper.dart';
import '../../theme/colors.dart';
import 'admin_bottomsheet.dart';
import 'admin_taskmodule_wise.dart';

class AdModules extends StatefulWidget {
  final String id;
   const AdModules(
      {Key? key,
        required this.id,}) : super(key: key);

  @override
  State<AdModules> createState() => _AdModulesState();
}

class _AdModulesState extends State<AdModules> {

  ///TaskList
  String? data;
  Map? moduleList;
  Map? moduleList1;
  List? finaModuleList;

  bool isLoading = true;

  @override
  void initState() {
    apiForModules();
    super.initState();
  }

  apiForModules() async {
    var response =
    await ApiHelper().post(endpoint: "project/Modules", body: {
      "project_id": widget.id,
      "offset": "0",
      "pageLimit": "50",
    }).catchError((err) {});

    setState(() {
      isLoading = false;
    });

    if (response != null) {
      setState(() {
        debugPrint('get products api successful:');
        data = response.toString();
        moduleList = jsonDecode(response);
        moduleList1 = moduleList!["pagination"];
        finaModuleList = moduleList1!["pageDataModules"];

        print(response);
      });
    } else {
      debugPrint('api failed:');
    }
  }


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
      body:  isLoading
          ? Center(child: CircularProgressIndicator(color: Color(ColorT.PrimaryColor),))
          : ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: finaModuleList == null ? 0 : finaModuleList?.length,
              itemBuilder: (context, index) => getModules(index),
      ),
    );
  }
  Widget getModules (int index) {
    return   Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => AdminTakModule(
                    id: finaModuleList![index]["id"].toString(),
                    position: index,
                    moduleId: widget.id,

                  )));
        },
        child: Container(
          height: MediaQuery.of(context).size.height / 6,
          decoration: BoxDecoration(
            border: Border.all(color: Color(ColorT.PrimaryColor),),
            borderRadius: BorderRadius.all(Radius.circular(15)),
            image: DecorationImage(
                image: AssetImage("assets/module bg.jpeg"), fit: BoxFit.fill),
          ),
          child:Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(finaModuleList![index]["module"].toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                Text(finaModuleList![index]["description"].toString(),
                  style: TextStyle(fontSize: 15),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
