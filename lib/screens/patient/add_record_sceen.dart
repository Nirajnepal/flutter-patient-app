import 'package:flutter/material.dart';
import 'package:patient_app/models/patientrecord.dart';
import 'package:patient_app/models/patient.dart';
import 'package:patient_app/screens/patient/patient_detail_screen.dart';
import 'package:patient_app/screens/services/api.services.dart';
import 'package:flutter/services.dart';
import 'record_screen.dart';

class AddRecordScreen extends StatefulWidget {
  final String userId;
  final String firstName;
  final Patient patient;
  AddRecordScreen(
      {required this.userId, required this.firstName, required this.patient});
  @override
  _AddRecordScreenState createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  final APIService apiService = APIService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final patientRecord = PatientRecord(
    userId: '',
    date: '',
    nurseName: '',
    bloodPressure: '',
    bloodOxygenLevel: '',
    heartbeatRate: '',
    height: '',
    weight: '',
  );

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        isLoading = true;
      });

      try {
        await apiService.addPatientRecord(
          id: widget.userId,
          date: patientRecord.date,
          nurseName: patientRecord.nurseName,
          bloodPressure: double.parse(patientRecord.bloodPressure),
          bloodOxygenLevel: double.parse(patientRecord.bloodOxygenLevel),
          heartbeatRate: double.parse(patientRecord.heartbeatRate),
          height: double.parse(patientRecord.height),
          weight: double.parse(patientRecord.weight),
        );

        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PatientDetailScreen(
                patient: widget.patient,
              ),
            ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to add record. Please try again later.'),
          ),
        );

        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Record'),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Card(
                child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Patient Name: ${widget.firstName}',
                                style: TextStyle(fontSize: 18.0),
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                initialValue: patientRecord.nurseName,
                                decoration: const InputDecoration(
                                  labelText: 'Nurse Name *',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter nurse name';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  patientRecord.nurseName = value ?? '';
                                },
                              ),
                              SizedBox(height: 8.0),
                              TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(8),
                                  TextInputFormatter.withFunction(
                                      (oldValue, newValue) {
                                    final regExp =
                                        RegExp(r'^(\d{0,4})(\d{0,2})(\d{0,2})');
                                    final match =
                                        regExp.firstMatch(newValue.text);
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
                                  labelText: 'Date (YYYY-MM-DD) *',
                                ),
                                onSaved: (val) =>
                                    setState(() => patientRecord.date = val!),
                                validator: (val) =>
                                    val!.isEmpty ? 'Date is required' : null,
                              ),
                              SizedBox(height: 8.0),
                              TextFormField(
                                initialValue: patientRecord.bloodPressure,
                                decoration: const InputDecoration(
                                  labelText: 'Blood Pressure *',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter blood pressure';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  patientRecord.bloodPressure = value ?? '';
                                },
                              ),
                              SizedBox(height: 8.0),
                              TextFormField(
                                initialValue: patientRecord.bloodOxygenLevel,
                                decoration: const InputDecoration(
                                  labelText: 'Blood Oxygen Level *',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter blood oxygen level';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  patientRecord.bloodOxygenLevel = value ?? '';
                                },
                              ),
                              SizedBox(height: 8.0),
                              TextFormField(
                                initialValue: patientRecord.heartbeatRate,
                                decoration: const InputDecoration(
                                  labelText: 'Heartbeat Rate *',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter heartbeat rate';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  patientRecord.heartbeatRate = value ?? '';
                                },
                              ),
                              SizedBox(height: 8.0),
                              TextFormField(
                                initialValue: patientRecord.height,
                                decoration: const InputDecoration(
                                  labelText: 'Height (in cm) *',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter height';
                                  } else if (double.tryParse(value) == null) {
                                    return 'Please enter a valid height';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  patientRecord.height = value ?? '';
                                },
                              ),
                              SizedBox(height: 8.0),
                              TextFormField(
                                initialValue: patientRecord.weight,
                                decoration: const InputDecoration(
                                  labelText: 'Weight (in kg) *',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter weight';
                                  } else if (double.tryParse(value) == null) {
                                    return 'Please enter a valid weight';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  patientRecord.weight = value ?? '';
                                },
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
                                      Icon(Icons.addchart, color: Colors.white),
                                      SizedBox(width: 10),
                                      Text(
                                        'Add Record',
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
                            ]))))));
  }
}
