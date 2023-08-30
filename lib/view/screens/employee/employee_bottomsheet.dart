import 'package:border_bottom_navigation_bar/border_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hawksApp/view/screens/employee/employee_profile.dart';
import 'package:hawksApp/view/screens/employee/employee_completed.dart';
import 'package:hawksApp/view/screens/employee/employee_pending.dart';
import 'package:hawksApp/view/screens/employee/employee_view.dart';
import 'package:hawksApp/view/theme/colors.dart';
import 'package:iconsax/iconsax.dart';

class EmployeeBottomSheet extends StatefulWidget {
  const EmployeeBottomSheet({Key? key}) : super(key: key);

  @override
  State<EmployeeBottomSheet> createState() => _EmployeeBottomSheetState();
}

class _EmployeeBottomSheetState extends State<EmployeeBottomSheet> {
  int _currentIndex = 0;
  List body = <Widget>[EmployeePage(), EmployeeCompleted(), EmployeePending(), EmployeeProfile()];

  Color getSelectedBackgroundColor(int index) {
    if (index == 0) {
      return Color(ColorT.PrimaryColor);
    } else if (index == 1) {
      return Colors.green.shade300;
    } else if (index == 2) {
      return Colors.red.shade300;
    } else if (index == 3) {
      return Color(ColorT.PrimaryColor);
    }
    return Colors.transparent; // Default color
  }

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
        selectedBackgroundColor: getSelectedBackgroundColor(_currentIndex),
        unselectedBackgroundColor: Colors.red.shade50,
        unselectedIconColor: Colors.grey.shade600,
        selectedIconColor: Colors.white,
        customBottomNavItems: [
          BorderBottomNavigationItems(
            icon: Iconsax.task_square,
          ),
          BorderBottomNavigationItems(
            icon: Iconsax.tick_circle,
          ),
          BorderBottomNavigationItems(
            icon: Iconsax.info_circle,
          ),
          BorderBottomNavigationItems(
            icon: Iconsax.user,
          ),
        ],
      ),
    );
  }
}
