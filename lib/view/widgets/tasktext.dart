import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskText extends StatelessWidget {
  final String task;
  final String res;

  TaskText({
    Key? key,
    required this.task, required this.res,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    task, style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  ),
                ),
                Container(
                  child: Text(
                    res, style: TextStyle(
                    fontSize: 15,
                  ),
                  ),
                ),
                Divider(
                )
              ],
            ),
          ),
          Divider(
            color: Colors.grey.shade200,thickness: 1,
          ),
        ],
      ),
    );
  }
}