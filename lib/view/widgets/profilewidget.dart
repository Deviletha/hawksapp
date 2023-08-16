import 'package:flutter/material.dart';

class ProfileRow extends StatelessWidget {
  final String title;
  final IconData icon;

  ProfileRow({
    Key? key,
    required this.title,
    required this.icon,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15,top: 10, bottom: 10),
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(left: 40, right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(icon, size: 25,color: Colors.grey.shade600,),
                SizedBox(width: 30),
                Expanded(
                  flex: 1,
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 18,color: Colors.grey.shade600),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey.shade200,thickness: 2,
          ),
        ],
      ),
    );
  }
}