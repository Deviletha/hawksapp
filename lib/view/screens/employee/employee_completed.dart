import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/tasktext.dart';

class EmplCompleted extends StatefulWidget {
  const EmplCompleted({Key? key}) : super(key: key);

  @override
  State<EmplCompleted> createState() => _EmplCompletedState();
}

class _EmplCompletedState extends State<EmplCompleted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.green.shade300,
        ),
        backgroundColor: Colors.green.shade300,
        title: Text("Completed Works"),
      ),
      body:   ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) => getCompletedTask(index),
      ),
    );
  }
  Widget getCompletedTask(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration:
        BoxDecoration(
            border: Border.all(color: Colors.grey, width: .2),
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green.shade300,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Task Title",  style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white
                    ),),
                    Text("Assigned date: 21/06/2023",  style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.white
                    ),),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),)
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text( "Project Name",style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),),
                          Text("Module title",style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),),
                          Divider(),
                        ],
                      ),
                      Divider(),
                      Text("There are many variations of passages of Lorem Ipsum available,"
                          " but the majority have suffered alteration in some form, "
                          "by injected humour, or randomised words which don't look"
                          " even slightly believable. If you are going to use a passage "
                          "of Lorem Ipsum, you need to be sure there isn't anything embarrassing "
                          "hidden in the middle of text. All the Lorem Ipsum generators on the "
                          "Internet tend to repeat predefined chunks as necessary, making this "
                          "the first true generator on the Internet. It uses a dictionary"
                          " of over 200 Latin words, combined with a handful of model "
                          "sentence structures, to generate Lorem Ipsum which looks reasonable."
                          "The generated Lorem Ipsum is therefore always free"
                          " from repetition, injected humour or non-characteristic words etc.",
                        maxLines: 5,style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade900
                        ),),
                      Divider(),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Started date :21/06/2023",
                            style: TextStyle(
                              fontSize: 10,
                            ),),
                          Text("Completed date: 21/06/2023",
                            style: TextStyle(
                              fontSize: 10,
                            ),),
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
    );
  }
}
