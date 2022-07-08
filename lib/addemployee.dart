// ignore_for_file: prefer_const_constructors

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/rendering.dart';

class addemployee extends StatefulWidget {
  @override
  State<addemployee> createState() => _addemployeeState();
}

class _addemployeeState extends State<addemployee> {
  late TextEditingController _nameController,
      _ageController,
      _jobtenureController;

  String _status = '';

  late DatabaseReference _ref;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _ageController = TextEditingController();
    _jobtenureController = TextEditingController();
    _ref = FirebaseDatabase(
            databaseURL:
                "https://employee-1fc23-default-rtdb.asia-southeast1.firebasedatabase.app")
        .ref()
        .child("employees");
  }

  Widget _buildStatusType(String title) {
    return InkWell(
      child: Container(
        height: 40,
        width: 90,
        decoration: BoxDecoration(
          color: _status == title ? Colors.green : Colors.grey,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
            child: Text(
          title,
          style: TextStyle(fontSize: 16, color: Colors.white),
        )),
      ),
      onTap: () {
        setState(() {
          _status = title;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Save Employee Details"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                  hintText: "Name",
                  prefixIcon: Icon(
                    Icons.account_circle,
                    size: 30,
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(28)),
                  filled: true,
                  contentPadding: EdgeInsets.all(15)),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: _ageController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(28)),
                prefixIcon: Icon(Icons.numbers),
                hintText: "Age",
                filled: true,
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: _jobtenureController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(28)),
                prefixIcon: Icon(Icons.calendar_month),
                hintText: "Job Tenure",
                filled: true,
              ),
            ),
            SizedBox(height: 15),
            Container(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildStatusType("Active"),
                  SizedBox(width: 10),
                  _buildStatusType("Inactive"),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                // ignore: prefer_const_constructors
                child: Text("Save"),
                onPressed: () {
                  save();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void save() {
    String name = _nameController.text;
    String age = _ageController.text;
    String jobtenure = _jobtenureController.text;

    Map<String, String> employee = {
      "name": name,
      "age": age,
      "status": _status,
      "job_tenure": jobtenure,
    };

    _ref.push().set(employee).then((value) {
      Navigator.pop(context);
    });
  }
}
