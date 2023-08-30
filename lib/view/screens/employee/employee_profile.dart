import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Config/ApiHelper.dart';
import '../../theme/colors.dart';
import '../../widgets/profilewidget.dart';

class EmployeeProfile extends StatefulWidget {
  const EmployeeProfile({Key? key}) : super(key: key);

  @override
  State<EmployeeProfile> createState() => _EmployeeProfileState();
}

class _EmployeeProfileState extends State<EmployeeProfile> {

  /// ScheduleList
  String? data;
  Map? profileList;
  List? finalProfileList;

  String? UID;
  bool isLoading = true;

  int index = 0;
  String? base = 'https://hawksapp.hawkssolutions.com/basicapi/public/';

  @override
  void initState() {
    checkUser();
    super.initState();
  }

  Future<void> checkUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      UID = prefs.getString("UID");
    });
    apiForProfile();
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


  @override
  @override
  Widget build(BuildContext context) {
    var image = base! + (finalProfileList?[index]["image"] ?? "").toString();
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Color(ColorT.PrimaryColor),))
          : finalProfileList == null
          ? Center(child: CircularProgressIndicator(color: Color(ColorT.PrimaryColor),))
          : ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 7.5,
            decoration: BoxDecoration(
              color: Color(ColorT.PrimaryColor),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(120),
              ),
            ),
            child: Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(image), radius: 50,
              ),
            ),
          ),
          SizedBox(height: 25),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Divider(
              color: Colors.grey.shade200,thickness: 2,
            ),
          ),
          ProfileRow(icon: Iconsax.user,title:finalProfileList![index]["name"].toString(),),
          ProfileRow(icon: Iconsax.designtools,title:finalProfileList![index]["designation"].toString(),),
          ProfileRow(icon: Iconsax.sms,title:finalProfileList![index]["email"].toString(),),
          ProfileRow(icon: Iconsax.call,title:finalProfileList![index]["contact"].toString(),),
          ProfileRow(icon: Iconsax.home,title:finalProfileList![index]["address"].toString(),),
        ],
      ),
    );
  }
}
