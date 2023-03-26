import 'package:flutter/material.dart';
import 'package:patient_app/models/patient.dart';
import 'package:patient_app/screens/services/api.services.dart';
import 'patient_detail_screen.dart';

class PatientUpdateScreen extends StatefulWidget {
  final Patient patient;

  const PatientUpdateScreen({Key? key, required this.patient})
      : super(key: key);

  @override
  _PatientUpdateScreenState createState() => _PatientUpdateScreenState();
}

class _PatientUpdateScreenState extends State<PatientUpdateScreen> {
  final APIService apiService = APIService();
  final _formKey = GlobalKey<FormState>();
  late Patient _patient;

  @override
  void initState() {
    super.initState();
    _patient = widget.patient;
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // final currentContext = context; // store the current context

      Future.delayed(Duration.zero, () async {
        try {
          await apiService.updatePatient(
            id: _patient.id,
            firstName: _patient.firstName,
            lastName: _patient.lastName,
            address: _patient.address,
            dateOfBirth: _patient.dateOfBirth,
            department: _patient.department,
            doctor: _patient.doctor,
          );

          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PatientDetailScreen(
                patient: _patient,
              ),
            ),
          );
        } catch (e) {
          print('Error updating patient: $e');
          // Show error message to user
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to update patient'),
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
        title: const Text('Update Patient'),
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
                  initialValue: _patient.firstName,
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
                  initialValue: _patient.lastName,
                  onSaved: (val) => setState(() => _patient.lastName = val!),
                  validator: (val) =>
                      val!.isEmpty ? 'Last Name is required' : null,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Address *',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: _patient.address,
                  onSaved: (val) => setState(() => _patient.address = val!),
                  validator: (val) =>
                      val!.isEmpty ? 'Date of Birth is required' : null,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Date of Birth *',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: _patient.dateOfBirth,
                  onSaved: (val) => setState(() => _patient.dateOfBirth = val!),
                  validator: (val) =>
                      val!.isEmpty ? 'Date of Birth is required' : null,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Department *',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: _patient.department,
                  onSaved: (val) => setState(() => _patient.department = val!),
                  validator: (val) =>
                      val!.isEmpty ? 'Date of Birth is required' : null,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Doctor *',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: _patient.doctor,
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
                        Icon(Icons.edit_document, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          'Update Patient',
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
      ),
    );
  }
}
