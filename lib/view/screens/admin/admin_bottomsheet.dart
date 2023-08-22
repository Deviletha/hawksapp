import 'package:border_bottom_navigation_bar/border_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hawksApp/view/screens/admin/admin_client.dart';
import 'package:hawksApp/view/screens/admin/admin_projects.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/colors.dart';
import 'admin_employeedetails.dart';
import 'admin_task.dart';


class AdminBottomSheet extends StatefulWidget {
  const AdminBottomSheet({Key? key}) : super(key: key);

  @override
  State<AdminBottomSheet> createState() => _AdminBottomSheetState();
}

class _AdminBottomSheetState extends State<AdminBottomSheet> {
  int _currentIndex = 0;
  List body = <Widget>[AdminPage(),AdEmployeePage(),AdProjects(),AdClient()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body.elementAt(_currentIndex),
      bottomNavigationBar: BorderBottomNavigationBar(
        height: 53,
        currentIndex: _currentIndex,
        borderRadiusValue: 25,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          print(index);
        },
        selectedLabelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
        selectedBackgroundColor: Color(ColorT.PrimaryColor),
        unselectedBackgroundColor: Colors.red.shade50,
        unselectedIconColor: Colors.grey.shade600,
        selectedIconColor: Colors.white,
        customBottomNavItems: [
          BorderBottomNavigationItems(
            icon:Iconsax.task_square,
          ),
          BorderBottomNavigationItems(
            icon:Iconsax.people,
          ),
          BorderBottomNavigationItems(
            icon:Iconsax.subtitle,
          ),
          BorderBottomNavigationItems(
            icon:Iconsax.personalcard,
          ),
        ],
      ),
    );
  }
}
