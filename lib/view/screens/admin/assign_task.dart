import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../theme/colors.dart';
import 'admin_bottomsheet.dart';

class AssignTask extends StatefulWidget {
  const AssignTask({Key? key}) : super(key: key);

  @override
  State<AssignTask> createState() => _AssignTaskState();
}

class _AssignTaskState extends State<AssignTask> {

  String dropdownValue1 = 'Option 1';
  String dropdownValue2 = 'Option 1';
  String dropdownValue3 = 'Option 1';
  String dropdownValue4 = 'Option 1';
  String dropdownValue5 = 'Option 1';
  String dropdownValue6 = 'Option 1';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Assign Task to Employees"),
          leading: IconButton(
            icon: Icon(Iconsax.arrow_left), onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => AdminBottomSheet()));
          },
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
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
                        child: Text("Task Title",  style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white
                        ),),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(ColorT.PrimaryColor),
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
                              bottomRight: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                            )
                        ),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all( 20),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Select Employee"),
                                  DropdownButton<String>(
                                    itemHeight: 50,
                                    value: dropdownValue1,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue1 = newValue!;
                                      });
                                    },
                                    items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                  Text("Select Project"),
                                  DropdownButton<String>(
                                    value: dropdownValue2,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue2 = newValue!;
                                      });
                                    },
                                    items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                  Text("Select Module"),
                                  DropdownButton<String>(
                                    value: dropdownValue3,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue3 = newValue!;
                                      });
                                    },
                                    items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                  Text("Select Task"),
                                  DropdownButton<String>(
                                    value: dropdownValue4,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue4 = newValue!;
                                      });
                                    },
                                    items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                  Text("Select Client"),
                                  DropdownButton<String>(
                                    value: dropdownValue5,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue5 = newValue!;
                                      });
                                    },
                                    items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                  Text("Select Priority"),
                                  DropdownButton<String>(
                                    value: dropdownValue6,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue6 = newValue!;
                                      });
                                    },
                                    items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),

                                ],
                              ),
                            ),
                            Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Color(ColorT.PrimaryColor),
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),
                                      bottomRight: Radius.circular(25),
                                  )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text("Assign to Employee",style: TextStyle(
                                    color: Colors.white
                                  ),),
                                )
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}