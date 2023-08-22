import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Config/ApiHelper.dart';
import '../theme/colors.dart';
import 'admin/admin_bottomsheet.dart';
import 'employee/employee_bottomsheet.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List? userList;
  String? UID;
  bool showpass = true;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  checkUser() async {
    final prefs = await SharedPreferences.getInstance();
    UID = prefs.getString("UID");
    print(UID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/login fi.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/hawks-logo.png",
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 35,
                  right: 35,
                  top: 80,
                  bottom: 20,
                ),
                child: TextFormField(
                  cursorColor: Colors.teal[900],
                  controller: usernameController,
                  decoration: InputDecoration(
                    fillColor: Colors.teal[100],
                    labelText: 'Phone Number',
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (uname) {
                    if (uname!.isEmpty || !uname.contains('')) {
                      return 'Enter a valid Phone Number';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 35,
                  right: 35,
                  top: 10,
                  bottom: 60,
                ),
                child: TextFormField(
                  cursorColor: Colors.teal[900],
                  controller: passwordController,
                  obscureText: showpass,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          showpass = !showpass;
                        });
                      },
                      icon: Icon(
                        showpass ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                    labelText: "Password",
                  ),
                  textInputAction: TextInputAction.done,
                  validator: (Password) {
                    if (Password!.isEmpty || Password.length < 6) {
                      return "Enter a valid Password, length should be greater than 6";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.height / 2.9,
                height: MediaQuery.of(context).size.height / 16,
                child: ElevatedButton(
                  onPressed: () async {
                    String username = usernameController.text.toString();
                    String password = passwordController.text.toString();
                    if (username.isNotEmpty && password.isNotEmpty) {
                      try {
                        var response = await ApiHelper().post(
                          endpoint: "common/authenticate",
                          body: {
                            'username': username,
                            'password': password,
                          },
                        );

                        if (response != null) {
                          setState(() {
                            debugPrint('API successful:');
                            userList = jsonDecode(response);
                            print(response);
                          });
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString(
                            "UID",
                            userList![0]["id"].toString(),
                          );
                          checkUser();
                          Fluttertoast.showToast(
                            msg: "Login success",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.SNACKBAR,
                            timeInSecForIosWeb: 1,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminBottomSheet(),
                            ),
                          );
                        } else {
                          // API call succeeded but returned a failure response
                          debugPrint('API failed:');
                          Fluttertoast.showToast(
                            msg: "Login failed. Please check your credentials.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.SNACKBAR,
                            timeInSecForIosWeb: 1,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      } catch (error) {
                        // Handle any exceptions that occur during the API call
                        debugPrint('API error: $error');
                        Fluttertoast.showToast(
                          msg: "An error occurred while processing your request.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.SNACKBAR,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    } else {
                      // Username or password is empty
                      Fluttertoast.showToast(
                        msg: "Please enter username and password",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.SNACKBAR,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(ColorT.PrimaryColor),
                    shadowColor: Colors.red[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                  ),
                  child: Text("Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
