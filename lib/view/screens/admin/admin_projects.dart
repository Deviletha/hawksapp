import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../Config/ApiHelper.dart';
import '../../theme/colors.dart';
import 'admin_modules.dart';

class AdProjects extends StatefulWidget {
  const AdProjects({Key? key}) : super(key: key);

  @override
  State<AdProjects> createState() => _AdProjectsState();
}

class _AdProjectsState extends State<AdProjects> {

  ///ProjectList
  String? data;
  Map? projectList;
  Map? projectList1;
  List? finalProjectList;

  bool isLoading = true;

  @override
  void initState() {
    apiForProject();
    super.initState();
  }

  apiForProject() async {
    var response =
    await ApiHelper().post(endpoint: "project/Projects", body: {
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
        projectList = jsonDecode(response);
        projectList1 = projectList!["pagination"];
        finalProjectList = projectList1!["pageDataProjects"];

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
        title: Text("Projects"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Color(ColorT.PrimaryColor),))
          :
      ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: finalProjectList == null ? 0 : finalProjectList?.length,
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
                  builder: (context) => AdModules(
                    id: finalProjectList![index]["id"].toString(),
                  )));
        },
        child: Container(
          height: MediaQuery.of(context).size.height / 3,
          decoration: BoxDecoration(
            border: Border.all(color: Color(ColorT.PrimaryColor),),
            borderRadius: BorderRadius.all(Radius.circular(15)),
            image: DecorationImage(
                image: AssetImage("assets/project_bg.jpeg"), fit: BoxFit.fill),
          ),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 10, bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(finalProjectList![index]["project"].toString(),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                    Text(finalProjectList![index]["description"].toString(),
                      style: TextStyle(fontSize: 15),),
                    Text("Client Name: ${finalProjectList![index]["clientName"]}",
                      style: TextStyle(fontSize: 15),),
                    Text("Project Type: ${finalProjectList![index]["projectType"]}",
                      style: TextStyle(fontSize: 15),),
                    Text("Project Subtype: ${finalProjectList![index]["projectSubType"]}",
                      style: TextStyle(fontSize: 15),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Total Cost: ₹ ${finalProjectList![index]["total_cost"]}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                    Text("Payment Date: ${finalProjectList![index]["payment_date"]}",
                      style: TextStyle(fontSize: 15),),
                    Text("Next payment date:  ${finalProjectList![index]["next_payment_date"]}",
                      style: TextStyle(fontSize: 15),),
                    Text("Amount Received: ₹ ${finalProjectList![index]["amount_received"]}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                    Text("Last paid date:  ${finalProjectList![index]["last_paid_date"]}",
                      style: TextStyle(fontSize: 15),),
                    Text("Last amount received: ₹ ${finalProjectList![index]["last_paid_amount"]}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
