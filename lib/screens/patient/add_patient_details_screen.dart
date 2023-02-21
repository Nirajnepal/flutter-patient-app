import 'package:flutter/material.dart';

class AddPatientScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Patient'),
      ),
      body: Center(
        child: Text('Add Patient Form'),
      ),
    );
  }
}
