import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Config/ApiHelper.dart';
import '../../theme/colors.dart';
import 'add_task.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _descriptionController = TextEditingController();

  /// ScheduleList
  String? data;
  Map? scheduleList;
  Map? scheduleList1;
  List? finalScheduleList;

  ///List for Update status
  Map? updateScheduleList;
  Map? updateScheduleList1;
  List? finalUpdateScheduleList;



  String? UID;
  bool isLoading = true;
  String? SCHEDULEID;

  String selectedStatus = "Start"; // Default status

  String selectedProject = "All"; // Default project value
  String selectedModule = "All"; // Default module value
  List<String> projectOptions = [
    "All"
  ]; // Initialize with "All" as the default option
  List<String> moduleOptions = [
    "All"
  ]; // Initialize with "All" as the default option

  @override
  void initState() {
    checkUser();
    apiForSchedules();
    super.initState();
  }



  void extractProjectAndModuleOptions() {
    if (finalScheduleList != null) {
      // Create sets to store unique project names and modules
      Set<String> projectSet = Set<String>();
      Set<String> moduleSet = Set<String>();

      for (var schedule in finalScheduleList!) {
        projectSet.add(schedule["project"].toString());
        moduleSet.add(schedule["module"].toString());
      }

      // Convert sets to lists and add "All" as the default option
      projectOptions = ["All", ...projectSet.toList()];
      moduleOptions = ["All", ...moduleSet.toList()];
    }
  }

  Future<void> checkUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      UID = prefs.getString("UID");
    });
  }

  List<String> base64Images = [];
  File? _pickedImage;

  void convertImageToBase64() async {
    if (_pickedImage != null) {
      final bytes = await _pickedImage!.readAsBytes();
      final String base64Image = "data:image/;base64,${base64Encode(bytes)}";
      setState(() {
        base64Images.add(base64Image);
      });
    }
  }

  void selectImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });
      convertImageToBase64();
    }
  }

  updateScheduleStatusApi(int statusValue, String scheduleId) async {
    var response = await ApiHelper().post(
      endpoint: "schedules/updateScheduleStatus",
      body: {
        "userid": UID,
        "schedule_id": scheduleId,
        "schedule_status": statusValue.toString(),
        "note": _descriptionController.text,
        "imageUrl": base64Images.isNotEmpty ? base64Images[0] : "",
      },
    ).catchError((err) {});

    if (response != null) {
      setState(() {
        debugPrint('update status api successful:');
        updateScheduleList = jsonDecode(response);
        updateScheduleList1 = updateScheduleList!["pagination"];
        finalUpdateScheduleList = updateScheduleList1!["pageDataSchedules"];
      });
    } else {
      debugPrint('update status failed:');
    }
  }

  apiForSchedules() async {
    var response =
        await ApiHelper().post(endpoint: "schedules/Schedules", body: {
      "offset": "0",
      "pageLimit": "50",
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
        extractProjectAndModuleOptions(); // Extract project and module options
      });
    } else {
      debugPrint('api failed:');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(ColorT.PrimaryColor),
        onPressed: () => Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return AddTask();
          },
        )),
        child: Icon(Iconsax.add),
      ),
      body: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 4.5,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25)),
                color: Color(ColorT.PrimaryColor),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Welcome",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                  color: Colors.white),
                            ),
                            Text(
                              "Hawks Solutions",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white),
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
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Select Project"),
                  DropdownButton<String>(
                    value: selectedProject,
                    onChanged: (String? newValue) {
                      // Update parameter type to String?
                      setState(() {
                        selectedProject = newValue ??
                            "All"; // Use null check operator and provide a default value
                      });
                    },
                    items: projectOptions.map((String project) {
                      return DropdownMenuItem<String>(
                        value: project,
                        child: Text(project),
                      );
                    }).toList(),
                  ),
                  Text("Select Module"),
                  DropdownButton<String>(
                    value: selectedModule,
                    onChanged: (String? newValue) {
                      // Update parameter type to String?
                      setState(() {
                        selectedModule = newValue ??
                            "All"; // Use null check operator and provide a default value
                      });
                    },
                    items: moduleOptions.map((String module) {
                      return DropdownMenuItem<String>(
                        value: module,
                        child: Text(module),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                    color: Color(ColorT.PrimaryColor),
                  ))
                : ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: finalScheduleList == null
                        ? 0
                        : finalScheduleList?.length,
                    itemBuilder: (context, index) {
                      // Check if the task matches the selected project and module
                      if ((selectedProject == "All" ||
                              finalScheduleList![index]["project"].toString() ==
                                  selectedProject) &&
                          (selectedModule == "All" ||
                              finalScheduleList![index]["module"].toString() ==
                                  selectedModule)) {
                        return getTask(index);
                      } else {
                        // Return an empty container for tasks that don't match the filters
                        return Container();
                      }
                    },
                  ),
          ],
        ),
      ]),
    );
  }

  Widget getTask(int index) {
    String scheduleStatusText = "";

    switch (finalScheduleList![index]["schedule_status"]) {
      case 0:
        scheduleStatusText = "Pending";
        break;
      case 1:
        scheduleStatusText = "Start";
        break;
      case 2:
        scheduleStatusText = "On Going";
        break;
      case 3:
        scheduleStatusText = "Completed";
        break;
      case 4:
        scheduleStatusText = "Hold";
        break;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          SCHEDULEID = finalScheduleList![index]["id"].toString();
          _showTaskBottomSheet();
        },
        child: Container(
          decoration: BoxDecoration(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        finalScheduleList![index]["task_name"].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                      Text(
                        "Assigned Date: ${finalScheduleList![index]["assigned_date"]}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.white),
                      ),
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
                      bottomLeft: Radius.circular(15),
                    )),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              finalScheduleList![index]["project"].toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              finalScheduleList![index]["module"].toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Divider(),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          finalScheduleList![index]["description"].toString(),
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade900),
                        ),
                        Divider(),
                        Text(
                          "Expected start date : ${finalScheduleList![index]["expected_start_date"]}",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        Divider(),
                        Text(
                          "Expected end date : ${finalScheduleList![index]["expected_end_date"]}",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 18,
                decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${finalScheduleList![index]["employeeName"]} : ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        scheduleStatusText,
                        style: TextStyle(
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

  void _showTaskBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Column(
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
                    value: selectedStatus,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedStatus = newValue!;
                      });
                    },
                    items: <String>['Start', 'Ongoing', 'Completed', 'On Hold']
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
                  SizedBox(
                    height: 10,
                  ),
                  IconButton(
                    onPressed: () {
                      selectImage();
                    },
                    icon: Icon(
                      Icons.add_a_photo,
                      color: Colors.teal[900],
                      size: 30,
                    ),
                  ),
                  _pickedImage != null
                      ? Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: FileImage(
                                    _pickedImage!,
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              border: Border.all(color: Colors.grey)),
                        )
                      : Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "assets/hawks-logo.png",
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              border: Border.all(color: Colors.grey)),
                        ),
                  ElevatedButton(
                    onPressed: () {
                      int statusValue;
                      switch (selectedStatus) {
                        case "Start":
                          statusValue = 1;
                          break;
                        case "Ongoing":
                          statusValue = 2;
                          break;
                        case "Completed":
                          statusValue = 3;
                          break;
                        case "On Hold":
                          statusValue = 4;
                          break;
                        default:
                          statusValue = 1; // Default to "Start"
                          break;
                      }
                      updateScheduleStatusApi(statusValue, SCHEDULEID!);
                      Navigator.pop(context); // Close the bottom sheet
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
