import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../Config/ApiHelper.dart';
import '../../theme/colors.dart';
import 'admin_modules.dart';

class AdminTakModule extends StatefulWidget {
  final int position;
  final String id;
  final String moduleId;
  const AdminTakModule(
      {Key? key,
        required this.position, required this.id, required this.moduleId,}) : super(key: key);

  @override
  State<AdminTakModule> createState() => _AdminTakModuleState();
}

class _AdminTakModuleState extends State<AdminTakModule> {

  ///ModuleList
  String? data;
  Map? taskList;
  Map? taskList1;
  List? finalModuleTaskList;
  List? finalTaskList;

  bool isLoading = true;

  @override
  void initState() {
    apiForModules();
    super.initState();
  }

  apiForModules() async {
    var response =
    await ApiHelper().post(endpoint: "project/moduleTasks", body: {
      "module_id": widget.id.toString(),
    }).catchError((err) {});

    setState(() {
      isLoading = false;
    });

    if (response != null) {
      setState(() {
        debugPrint('get task api successful:');
        data = response.toString();
        taskList = jsonDecode(response);
        taskList1 = taskList!["tasks"];
        finalModuleTaskList = taskList1!["pageData"];
        finalTaskList = finalModuleTaskList![0]["tasks"];
      });
    } else {
      debugPrint('api failed:');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            finalModuleTaskList?[0]["module"] ?? "Module Name Not Available"),
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AdModules(id: widget.moduleId),
              ),
            );
          },
        ),
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(
          color: Color(ColorT.PrimaryColor),
        ),
      )
          : ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: finalTaskList?.length ?? 0,
        itemBuilder: (context, index) => getModules(index),
      ),
    );
  }

  Widget getModules(int index) {
    if (finalTaskList != null && finalTaskList!.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height / 6,
          decoration: BoxDecoration(
            border: Border.all(color: Color(ColorT.PrimaryColor),),
            borderRadius: BorderRadius.all(Radius.circular(15)),
            image: DecorationImage(
              image: AssetImage("assets/module bg.jpeg"),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(finalTaskList![index]["task_name"].toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Text(finalTaskList![index]["task_description"].toString(),
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      // Handle the case where finalTaskList is null or empty
      return Container(); // Or you can return a placeholder or error message
    }
  }
}
