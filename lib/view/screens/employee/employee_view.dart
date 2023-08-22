import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/colors.dart';
import '../login_page.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({Key? key}) : super(key: key);

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {

  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Color(ColorT.PrimaryColor),
        ),
      ),
      body: ListView(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
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
                                "Hello Employee",
                                style:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 28,color: Colors.white ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Have a nice day!",
                                style:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
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
        ],
      ),
    );
  }
  Widget getTask(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          _showTaskBottomSheet();
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
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Start date :21/06/2023",
                              style: TextStyle(
                                  fontSize: 10,
                              ),),
                            Text("End date: 21/06/2023",
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
      ),
    );
  }
  void _showTaskBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Select Status',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              DropdownButton<String>(
                borderRadius: BorderRadius.circular(15),
                // Customize the dropdown button as needed
                onChanged: (String? newValue) {
                  // Handle dropdown selection here
                },
                items: <String>['Start','In Progress','Pending', 'Completed','0n Hold']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              TextFormField(
                maxLines: 5,
                controller: _descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  labelText: "Give description about status",
                ),
                textInputAction: TextInputAction.next,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the bottom sheet
                },
                child: Text('Submit'),
              ),
            ],
          ),
        );
      },
    );
  }
}
