import 'package:flutter/material.dart';
import 'package:patient_app/models/patient.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({Key? key}) : super(key: key);

  @override
  _AddPatientScreenState createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  final _formKey = GlobalKey<FormState>();
  final _patient = Patient(
      firstName: '',
      lastName: '',
      address: '',
      dateOfBirth: '',
      department: '',
      doctor: '');

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // TODO: Add patient to API
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Patient'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'First Name *',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (val) => setState(() => _patient.firstName = val!),
                    validator: (val) =>
                        val!.isEmpty ? 'First Name is required' : null,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Last Name *',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (val) => setState(() => _patient.lastName = val!),
                    validator: (val) =>
                        val!.isEmpty ? 'Last Name is required' : null,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Date of Birth *',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (val) =>
                        setState(() => _patient.dateOfBirth = val!),
                    validator: (val) =>
                        val!.isEmpty ? 'Date of Birth is required' : null,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Address *',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (val) => setState(() => _patient.address = val!),
                    validator: (val) =>
                        val!.isEmpty ? 'Address is required' : null,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Department *',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (val) =>
                        setState(() => _patient.department = val!),
                    validator: (val) =>
                        val!.isEmpty ? 'Department is required' : null,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Doctor *',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (val) => setState(() => _patient.doctor = val!),
                    validator: (val) =>
                        val!.isEmpty ? 'Doctor is required' : null,
                  ),
                  const SizedBox(height: 32.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 24),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.person_add, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            'Add Patient',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
