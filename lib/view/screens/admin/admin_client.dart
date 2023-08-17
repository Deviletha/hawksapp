import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class AdClient extends StatefulWidget {
  const AdClient({Key? key}) : super(key: key);

  @override
  State<AdClient> createState() => _AdClientState();
}

class _AdClientState extends State<AdClient> {
  final _clientController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clients"),
      ),
      body: ListView(
        children: [
          ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: 15,
            itemBuilder: (context, index) => clients(index),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _clientController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                labelText: "Type New Client",
              ),
              textInputAction: TextInputAction.next,
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Add"),
          ),
        ],
      ),
    );
  }

  Widget clients(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/client bg.jpeg"), fit: BoxFit.fill),
          border: Border.all(
            color: Color(ColorT.PrimaryColor),
          ),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Center(
          child: Text(
            "Client Name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
