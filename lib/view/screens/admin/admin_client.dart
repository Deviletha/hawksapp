import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../Config/ApiHelper.dart';
import '../../theme/colors.dart';

class AdClient extends StatefulWidget {
  const AdClient({Key? key}) : super(key: key);

  @override
  State<AdClient> createState() => _AdClientState();
}

class _AdClientState extends State<AdClient> {
  // final _clientController = TextEditingController();

  ///ClientList
  String? data;
  Map? clientList;
  Map? clientList1;
  List? finalClientList;

  bool isLoading = true;

  @override
  void initState() {
    apiForClients();
    super.initState();
  }

  apiForClients() async {
    var response = await ApiHelper().post(endpoint: "project/Clients", body: {
      "offset": "0",
      "pageLimit": "50",
    }).catchError((err) {});

    setState(() {
      isLoading = false;
    });

    if (response != null) {
      setState(() {
        debugPrint('get products api successful:');
        data = response.toString();
        clientList = jsonDecode(response);
        clientList1 = clientList!["pagination"];
        finalClientList = clientList1!["pageDataProjects"];
      });
    } else {
      debugPrint('api failed:');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clients"),
      ),
      body:
      // ListView(
      //   children: [
          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                  color: Color(ColorT.PrimaryColor),
                ))
              : ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:  finalClientList == null ? 0 : finalClientList?.length,
                  itemBuilder: (context, index) => getClients(index),
                ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextFormField(
          //     controller: _clientController,
          //     decoration: InputDecoration(
          //       border: OutlineInputBorder(
          //           borderRadius: BorderRadius.all(Radius.circular(15))),
          //       labelText: "Type New Client",
          //     ),
          //     textInputAction: TextInputAction.next,
          //   ),
          // ),
          // ElevatedButton(
          //   onPressed: () {},
          //   child: Text("Add"),
          // ),
      //   ],
      // ),
    );
  }

  Widget getClients(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 4.5,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          // image: DecorationImage(
          //     image: AssetImage("assets/client bg.jpeg"), fit: BoxFit.fill),
          border: Border.all(
            color: Color(ColorT.PrimaryColor),
          ),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                finalClientList![index]["name"].toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              Text("Address: ${finalClientList![index]["address"]}",
                style: TextStyle( fontSize: 15),maxLines: 4,),
              Text("Location: ${finalClientList![index]["location"]}",
                style: TextStyle(fontSize: 15),),
              Text("Email Id: ${finalClientList![index]["email"]}",
                style: TextStyle( fontSize: 15),),
              Text("Mobile No: ${finalClientList![index]["contact"]}",
                style: TextStyle( fontSize: 15),),
            ],
          ),
        ),
      ),
    );
  }
}
