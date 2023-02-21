import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:patient_app/screens/patient/patient_lists_screen.dart';
import 'package:patient_app/screens/patient/add_patient_details_screen.dart';

class HomeScreen extends StatelessWidget {
  static const patientIcon = Image(image: AssetImage('assets/patient.png'));
  static const addPatientIcon =
      Image(image: AssetImage('assets/addPatient.png'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Clinical Data Management'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PatientListScreen()));
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/patient.png",
                        height: 60,
                        width: 60,
                      ),
                      SizedBox(height: 10),
                      Text("View Patients"),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddPatientScreen()));
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/addPatient.png",
                        height: 60,
                        width: 60,
                      ),
                      SizedBox(height: 10),
                      Text("Add Patient"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
