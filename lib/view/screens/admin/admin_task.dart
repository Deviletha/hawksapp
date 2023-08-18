import 'package:flutter/material.dart';
import 'package:hawksApp/view/screens/login_page.dart';
import 'package:hawksApp/view/widgets/tasktext.dart';
import 'package:iconsax/iconsax.dart';

import '../../theme/colors.dart';
import 'add_task.dart';
import 'admin_view.dart';

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
              height: 220,
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
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        icon: Icon(
                          Icons.power_settings_new_outlined,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminView()));
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12))
                        ),
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Iconsax.task),
                            SizedBox(
                              width: 8,
                            ),
                            Text("Manage your task information"),
                          ],
                        ),
                      ),
                    ),
                  )
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
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Task Title",  style: TextStyle(
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
                  color: Color(ColorT.PrimaryColor),
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
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      SizedBox(
                        height: 10,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Divider(),
                      Text("There are many variations of passages of Lorem Ipsum available,"
                          " but the majority have suffered alteration in some form, "
                          "by injected humour, or randomised words which don't look"
                          " even slightly believable. If you are going to use a passage "
                          "of Lorem Ipsum, you need to be sure there isn't anything embarrassing "
                          "hidden in the middle of text. All the Lorem Ipsum generators on the "
                          "Internet tend to repeat predefined chunks as necessary, making this "
                          "the first true generator on the Internet. It uses a dictionary"
                          " of over 200 Latin words, combined with a handful of model "
                          "sentence structures, to generate Lorem Ipsum which looks reasonable."
                          "The generated Lorem Ipsum is therefore always free"
                          " from repetition, injected humour or non-characteristic words etc.",
                        maxLines: 5,style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade900
                        ),),
                      Divider(),
                      Text("Expected start date :21/06/2023",
                        style: TextStyle(
                          fontSize: 10,
                        ),),
                      Divider(),
                      Text("Expected end date : 21/06/2023",
                        style: TextStyle(
                          fontSize: 10,
                        ),),
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
