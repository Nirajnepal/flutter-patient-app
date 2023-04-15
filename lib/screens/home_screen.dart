import 'package:flutter/material.dart';
import 'package:patient_app/models/user.dart';
import 'package:patient_app/screens/patient/patient_lists_screen.dart';
import 'package:patient_app/screens/patient/add_patient_details_screen.dart';

class HomeScreen extends StatelessWidget {
  final User user;
  const HomeScreen({Key? key, required this.user}) : super(key: key);

  void _handleLogout(BuildContext context) {
    // Navigate back to the login screen
    Navigator.of(context).pushReplacementNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Clinical Data Management'),
        actions: [
          TextButton(
            onPressed: () => _handleLogout(context),
            child: const Icon(
              Icons.power_settings_new, // Use the power button icon
              color: Colors.red,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align children to the left
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 30,
                left: 16.0,
                bottom: 30.0), // Add padding to the top, left and bottom
            child: Text(
              "Hello, ${user.fullName}",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
          ),
          Row(
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
        ],
      ),
    );
  }
}
