import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../Config/ApiHelper.dart';
import '../../theme/colors.dart';

class AdEmployeePage extends StatefulWidget {
  const AdEmployeePage({Key? key}) : super(key: key);

  @override
  State<AdEmployeePage> createState() => _AdEmployeePageState();
}

class _AdEmployeePageState extends State<AdEmployeePage> {

  ///EmployeeList
  String? data;
  Map? employeeList;
  Map? employeeList1;
  List? finalEmployeeList;

  bool isLoading = true;

  @override
  void initState() {
    apiForEmployee();
    super.initState();
  }

  apiForEmployee() async {
    var response =
    await ApiHelper().post(endpoint: "employee", body: {
      "table": "employees",
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
        employeeList = jsonDecode(response);
        employeeList1 = employeeList!["pagination"];
        finalEmployeeList = employeeList1!["pageData"];
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
        title: Text("Employees Details"),
      ),
      body:  isLoading
          ? Center(child: CircularProgressIndicator(color: Color(ColorT.PrimaryColor),))
      : ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: finalEmployeeList == null ? 0 : finalEmployeeList?.length,
        itemBuilder: (context, index) => getEmployee(index),
      ),
    );
  }
  Widget getEmployee (int index) {
    return   Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 4.8,
        decoration: BoxDecoration(
          border: Border.all(color: Color(ColorT.PrimaryColor),),
          borderRadius: BorderRadius.all(Radius.circular(15)),
          image: DecorationImage(
              image: AssetImage("assets/employeebg.jpg"), fit: BoxFit.fill),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(finalEmployeeList![index]["name"].toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
              Text(finalEmployeeList![index]["value"].toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
              Text(finalEmployeeList![index]["department_name"].toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
              Text("Date of Joining: ${finalEmployeeList![index]["doj"]}",
                style: TextStyle(fontSize: 15),),
              Text("Mobile No: ${finalEmployeeList![index]["contact"]}",
                style: TextStyle( fontSize: 15),),
              Text("Email Id: ${finalEmployeeList![index]["email"]}",
                style: TextStyle( fontSize: 15),),
              Text("Address: ${finalEmployeeList![index]["address"]}",
                style: TextStyle( fontSize: 15),),
            ],
          ),
        ),
      ),
    );
  }
}
