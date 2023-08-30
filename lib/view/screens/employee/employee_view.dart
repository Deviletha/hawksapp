import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Config/ApiHelper.dart';
import '../../theme/colors.dart';
import '../login_page.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({Key? key}) : super(key: key);

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  final _descriptionController = TextEditingController();

  /// ScheduleList
  String? data;
  Map? scheduleList;
  Map? scheduleList1;
  List? finalScheduleList;

  Map? updateScheduleList;
  Map? updateScheduleList1;
  List? finalUpdateScheduleList;

  /// ProfileList
  Map? profileList;
  List? finalProfileList;

  String? UID;
  bool isLoading = true;
  String? SCHEDULEID;
  String?  EMPLOYEEDESIGNATION;
  int index = 0;

  String selectedStatus = "Start"; // Default status

  // Add these variables at the top of your _EmployeePageState class
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
    super.initState();
  }

  apiForProfile() async {
    var response =
    await ApiHelper().post(endpoint: "employee/getEmployeeDetails", body: {
      "id": UID,
    }).catchError((err) {});

    setState(() {
      isLoading = false;
    });

    if (response != null) {
      setState(() {
        debugPrint('profile api successful:');
        data = response.toString();
        profileList = jsonDecode(response);
        finalProfileList = profileList!["result"];
        print(response);
      });
    } else {
      debugPrint('api failed:');
    }
  }
  // Inside your initState function, after fetching the schedule data, extract project and module options
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

        // Call a function to extract project and module options
        extractProjectAndModuleOptions();

        print(response);
      });
    } else {
      debugPrint('api failed:');
    }
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
      print("userid${UID!}");
    });
    apiForSchedules();
    apiForProfile();
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Color(ColorT.PrimaryColor),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Color(ColorT.PrimaryColor),
              ),
            )
          : finalScheduleList == null
              ? Center(
                  child: CircularProgressIndicator(
                    color: Color(ColorT.PrimaryColor),
                  ),
                )
              : ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 6.5,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Hello ${finalScheduleList![index]["employeeName"]}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 28,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "Have a nice day!",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()));
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
                                ),
                              )
                            : finalScheduleList == null
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: Color(ColorT.PrimaryColor),
                                    ),
                                  )
                                : ListView.builder(
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: finalScheduleList?.length ?? 0,
                                    itemBuilder: (context, index) =>
                                        getTask(index),
                                  ),
                      ],
                    ),
                  ],
                ),
    );
  }

  Widget getTask(int index) {
    // Filter tasks based on selectedProject and selectedModule
    bool shouldShowTask = true;

    if (selectedProject != "All" &&
        finalScheduleList![index]["project"].toString() != selectedProject) {
      shouldShowTask = false;
    }

    if (selectedModule != "All" &&
        finalScheduleList![index]["module"].toString() != selectedModule) {
      shouldShowTask = false;
    }

    // Return the task widget based on the filtering result
    return shouldShowTask
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                SCHEDULEID = finalScheduleList![index]["id"].toString();
                EMPLOYEEDESIGNATION = finalProfileList![index]["Desigvalue"].toString();
                _showTaskBottomSheet(EMPLOYEEDESIGNATION!);
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: .2),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 16,
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
                              bottomRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    finalScheduleList![index]["project"]
                                        .toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    finalScheduleList![index]["module"]
                                        .toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Divider(),
                                ],
                              ),
                              Divider(),
                              Text(
                                finalScheduleList![index]["description"]
                                    .toString(),
                                maxLines: 5,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey.shade900),
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Start Date: ${finalScheduleList![index]["expected_start_date"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    "End Date: ${finalScheduleList![index]["expected_end_date"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
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
          )
        : SizedBox
            .shrink(); // If shouldShowTask is false, return an empty SizedBox
  }

  void _showTaskBottomSheet(String employeeDesignation) {
    List<String> availableStatuses;
    // Determine available statuses based on employee designation
    if (employeeDesignation == "Project Manager") {
      availableStatuses = ['Start', 'Ongoing', 'Done', 'On Hold', 'Approved', 'Rejected'];
    } else if (employeeDesignation == "Developer") {
      availableStatuses = ['Start', 'Ongoing', 'Done', 'On Hold'];
    } else {
      availableStatuses = ['Start', 'Ongoing', 'Done', 'On Hold']; // Default
    }

    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(10),
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
                      items: availableStatuses.map<DropdownMenuItem<String>>((String value) {
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
                            height: 150,
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
                            height: 150,
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
                          case "Done":
                            statusValue = 5;
                            break;
                          case "On Hold":
                            statusValue = 4;
                            break;
                          case "Approved":
                            statusValue = 6;
                            break;
                          case "Rejected":
                            statusValue = 7;
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
          ),
        );
      },
    );
  }
}
