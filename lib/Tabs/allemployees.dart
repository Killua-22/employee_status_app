// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:employee_status_app/addemployee.dart';

class allemployeesUI extends StatefulWidget {
  const allemployeesUI({Key? key}) : super(key: key);

  @override
  State<allemployeesUI> createState() => _allemployeesUIState();
}

class _allemployeesUIState extends State<allemployeesUI> {
  late Query _ref;

  void initState() {
    super.initState();
    _ref = FirebaseDatabase(
            databaseURL:
                "https://employee-1fc23-default-rtdb.asia-southeast1.firebasedatabase.app")
        .ref()
        .child("employees")
        .orderByChild("name");
  }

  Widget buildContactItem({Map? employee}) {
    Color statusColor =
        getStatusColor(employee!["status"], employee["job_tenure"]);
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            bottomLeft: Radius.circular(5),
            topRight: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
        ),
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              isThreeLine: true,
              title: Text(
                employee["name"],
                maxLines: 1,
                style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 63, 58, 58),
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Row(children: [
                      Text(
                        employee["age"],
                        style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 84, 75, 75),
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        " , joined",
                        style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 84, 75, 75),
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        employee["job_tenure"],
                        style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 84, 75, 75),
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        employee["job_tenure"] != "1"
                            ? " years ago"
                            : " year ago",
                        style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 84, 75, 75),
                            fontWeight: FontWeight.w600),
                      ),
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        // SizedBox(width: 70),
                        Text(
                          "Status: ",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 84, 75, 75),
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          employee["status"],
                          style: TextStyle(
                              fontSize: 12,
                              color: statusColor,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ]),
              leading: Icon(Icons.person, size: 70),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: FirebaseAnimatedList(
        query: _ref,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          Map employee = snapshot.value as Map;
          return buildContactItem(employee: employee);
        },
      ),
    );
  }

  Color getStatusColor(String status, String job_tenure) {
    Color color = Theme.of(context).primaryColor;

    if (status == "Active" && int.parse(job_tenure) >= 5) {
      color = Colors.green;
    } else if (status == "Inactive") {
      color = Colors.red;
    } else {
      color = Colors.blueAccent;
    }
    return color;
  }
}
