import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Config/ApiHelper.dart';

class EmployeeCompleted extends StatefulWidget {
  const EmployeeCompleted({Key? key}) : super(key: key);

  @override
  State<EmployeeCompleted> createState() => _EmployeeCompletedState();
}

class _EmployeeCompletedState extends State<EmployeeCompleted> {


  /// ScheduleList
  String? data;
  Map? scheduleList;
  Map? scheduleList1;
  List? finalScheduleList;

  String? UID;
  bool isLoading = true;

  @override
  void initState() {
    checkUser();
    super.initState();
  }

  Future<void> checkUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      UID = prefs.getString("UID");
      print("userid${UID!}");
    });
    apiForSchedules();
  }

  apiForSchedules() async {
    var response = await ApiHelper()
        .post(endpoint: "schedules/getEmployeeSchedules", body: {
      "id": UID,
    }).catchError((err) {});

    setState(() {
      isLoading = false;
    });

    if (response != null) {
      setState(() {
        debugPrint('get schedules api successful:');
        data = response.toString();
        scheduleList = jsonDecode(response);
        scheduleList1 = scheduleList!["pagination"];
        finalScheduleList = scheduleList1!["pageDataSchedules"];
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
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.green.shade300,
        ),
        backgroundColor: Colors.green.shade300,
        title: Text("Completed Works"),
      ),
      body:  isLoading
          ? Center(
        child: CircularProgressIndicator(
          color: Colors.green.shade300,
        ),
      )
          : finalScheduleList == null
          ? Center(
        child: CircularProgressIndicator(
          color: Colors.green.shade300,
        ),
      )
          :  ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: finalScheduleList!.length,
        itemBuilder: (context, index) {
          // Check if the schedule_status is 0
          if (finalScheduleList![index]["schedule_status"] == 3) {
            return getCompletedTask(index);
          } else {
            // If schedule_status is not 0, return an empty container or null
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
  Widget getCompletedTask(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration:
        BoxDecoration(
            border: Border.all(color: Colors.grey, width: .2),
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 16,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green.shade300,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Text(finalScheduleList![index]["task_name"].toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white
                    ),),
                    Text("Assigned Date:${finalScheduleList![index]["assigned_date"]}", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.white
                    ),),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),)
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          Text(finalScheduleList![index]["project"].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),),
                          Text( finalScheduleList![index]["module"].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),),
                          Divider(),
                        ],
                      ),
                      Divider(),
                      Text(
                          finalScheduleList![index]["description"].toString(),
                        maxLines: 5,style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade900
                        ),),
                      Divider(),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          Text( "Started Date: ${finalScheduleList![index]["actual_start_date"]}",
                            style: TextStyle(
                              fontSize: 10,
                            ),),
                          Text("Completed Date: ${finalScheduleList![index]["actual_end_date"]}",
                            style: TextStyle(
                              fontSize: 10,
                            ),),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
