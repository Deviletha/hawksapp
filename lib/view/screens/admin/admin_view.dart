import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/colors.dart';
import '../../widgets/tasktext.dart';
import 'admin_task.dart';
import 'assign_task.dart';

class AdminView extends StatefulWidget {
  const AdminView({Key? key}) : super(key: key);

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Information's"),
        leading: IconButton(
             icon: Icon(Iconsax.arrow_left), onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => AdminPage()));
        },
        ),
      ),
      body: Center(
        child: ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) => getTask(index),
        ),
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
              borderRadius: BorderRadius.all(Radius.circular(25))),
          child: Column(
            children: [
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(ColorT.PrimaryColor),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
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
                      topLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),)
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
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
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25))
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
