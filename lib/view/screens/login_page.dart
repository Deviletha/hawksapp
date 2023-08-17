import 'package:flutter/material.dart';
import 'admin/admin_bottomsheet.dart';
import 'employee/employee_bottomsheet.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/login fi.jpg"), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Image.asset("assets/hawks-logo.png", height: 100,),
              SizedBox(
                height: 60,
              ),
              InkWell(
                onTap: (){
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => EmployeeBottomSheet()));
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.red.shade100
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.supervised_user_circle),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Login as Employee")
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              InkWell(
                onTap: (){
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => AdminBottomSheet()));
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.brown.shade100
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.admin_panel_settings),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Login as Admin")
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 65,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
