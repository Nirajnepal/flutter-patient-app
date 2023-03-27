import 'package:flutter/material.dart';
import 'package:patient_app/models/patient.dart';
import 'patient_detail_screen.dart';
import 'package:patient_app/screens/services/api.services.dart';
import 'package:flutter/services.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({Key? key}) : super(key: key);

  @override
  _AddPatientScreenState createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  final APIService apiService = APIService();
  final _formKey = GlobalKey<FormState>();
  final _patient = Patient(
      firstName: '',
      lastName: '',
      address: '',
      dateOfBirth: '',
      department: '',
      doctor: '');

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // final currentContext = context; // store the current context

      Future.delayed(Duration.zero, () async {
        try {
          Patient addedPatient = await apiService.addPatient(
            firstName: _patient.firstName,
            lastName: _patient.lastName,
            address: _patient.address,
            dateOfBirth: _patient.dateOfBirth,
            department: _patient.department,
            doctor: _patient.doctor,
          );
          // print("$_patient");

          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PatientDetailScreen(
                patient: addedPatient,
              ),
            ),
          );
        } catch (e) {
          print('Error adding patient: $e');
          // Show error message to user
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to add patient'),
            ),
          );
        }
      });
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
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(8),
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        final regExp = RegExp(r'^(\d{0,4})(\d{0,2})(\d{0,2})');
                        final match = regExp.firstMatch(newValue.text);
                        if (match != null) {
                          return TextEditingValue(
                            text:
                                '${match.group(1)}${match.group(2)?.isNotEmpty == true ? '-${match.group(2)}' : ''}${match.group(3)?.isNotEmpty == true ? '-${match.group(3)}' : ''}',
                            selection: TextSelection.collapsed(
                                offset:
                                    '${match.group(1)}${match.group(2)?.isNotEmpty == true ? '-${match.group(2)}' : ''}${match.group(3)?.isNotEmpty == true ? '-${match.group(3)}' : ''}'
                                        .length),
                          );
                        }
                        return oldValue;
                      }),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Date of Birth (YYYY-MM-DD) *',
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
