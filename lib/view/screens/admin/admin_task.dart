import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/colors.dart';
import 'add_task.dart';
import 'assign_task.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(ColorT.PrimaryColor),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AddTask();
        },)),
        child:  Icon(Iconsax.add),
      ),
      body: ListView(
        children : [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height:MediaQuery.of(context).size.height / 4.5,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(25)
                  , bottomLeft: Radius.circular(25)),
                  color: Color(ColorT.PrimaryColor),),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Welcome",
                              style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 35,color: Colors.white ),
                            ),
                            Text(
                              "Hawks Solutions",
                              style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
                            ),

                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          Navigator.of(context).pop();

                          // Clear the user session data
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.remove("UID");
                          Fluttertoast.showToast(
                            msg: "Logged out",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.SNACKBAR,
                            timeInSecForIosWeb: 1,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        },
                        icon: Icon(
                          Icons.power_settings_new_outlined,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) => getTask(index),
            ),
          ],
        ),
        ]
      ),
    );
  }

  Widget getTask(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => AssignTask()));
        },
        child: Container(
          decoration:
          BoxDecoration(
              border: Border.all(color: Colors.grey, width: .2),
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 15,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(ColorT.PrimaryColor),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Work Status",  style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white
                      ),),
                      Text("Assigned date: 21/06/2023",  style: TextStyle(
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
                    color:Color(ColorT.PrimaryColor),
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
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text( "Project Name",style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),
                            Text("Module title",style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),
                            Divider(),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Task Description: It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                          maxLines: 2,style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade900
                          ),),
                        Divider(),
                        Text("Expected start date :21/06/2023",
                          style: TextStyle(
                            fontSize: 13,
                          ),),
                        Divider(),
                        Text("Expected end date : 21/06/2023",
                          style: TextStyle(
                            fontSize: 13,
                          ),),
                        Divider(),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height:MediaQuery.of(context).size.height / 18,
                decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Employee Name : ", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      ),
                      Text(
                        "Work status", style: TextStyle(
                        fontSize: 15,
                      ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
