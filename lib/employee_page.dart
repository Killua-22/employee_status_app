import 'package:employee_status_app/addemployee.dart';
import 'package:flutter/material.dart';
import '../Tabs/allemployees.dart';

class employeeUI extends StatefulWidget {
  const employeeUI({Key? key}) : super(key: key);

  @override
  State<employeeUI> createState() => _employeeUIState();
}

class _employeeUIState extends State<employeeUI> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Employees",
              textHeightBehavior: TextHeightBehavior(
                  leadingDistribution: TextLeadingDistribution.proportional),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0,
          ),
          body: allemployeesUI(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return addemployee();
              }));
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 209, 208, 208),
        ),
      ),
    );
  }
}
