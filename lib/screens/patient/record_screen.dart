import 'package:flutter/material.dart';
import 'package:patient_app/screens/services/api.services.dart';
import 'package:patient_app/models/patientrecord.dart';

class RecordScreen extends StatefulWidget {
  final String userId;
  final String firstName;

  RecordScreen({required this.userId, required this.firstName});

  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final APIService apiService = APIService();
  bool isLoading = true;
  bool hasRecord = false;
  bool showAddRecordButton = false;
  PatientRecord? record;
  String? recordId;
  String nurseName = '';
  String date = '';
  String bloodPressure = '';
  String bloodOxygenLevel = '';
  String heartbeatRate = '';
  String height = '';
  String weight = '';

  Future<void> getRecord() async {
    setState(() {
      isLoading = true;
    });

    try {
      final Map<String, dynamic> response =
          await apiService.getPatientRecords(widget.userId);

      if (response.containsKey('user_id')) {
        record = PatientRecord.fromJson(response);
        recordId = record?.id;
        nurseName = record?.nurseName ?? '';
        bloodPressure = record?.bloodPressure ?? '';
        bloodOxygenLevel = record?.bloodOxygenLevel ?? '';
        heartbeatRate = record?.heartbeatRate ?? '';
        height = record?.height ?? '';
        weight = record?.weight ?? '';
        setState(() {
          hasRecord = true;
          isLoading = false;
          showAddRecordButton = false; // Show the "Add Record" button
        });
      } else {
        setState(() {
          hasRecord = false;
          isLoading = false;
          showAddRecordButton = true; // Show the "Add Record" button
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to load record. Please try again later.'),
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getRecord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Record'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hasRecord
              ? SingleChildScrollView(
                  child: Form(
                    child: SingleChildScrollView(
                      child: Card(
                        margin: EdgeInsets.all(16.0),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Patient Name: ${widget.firstName}',
                                style: TextStyle(fontSize: 18.0),
                              ),
                              SizedBox(height: 8.0),
                              TextFormField(
                                initialValue: nurseName,
                                decoration: InputDecoration(
                                  labelText: 'Nurse Name',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter nurse name';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  nurseName = value ?? '';
                                },
                              ),
                              SizedBox(height: 8.0),
                              TextFormField(
                                initialValue: bloodPressure,
                                decoration: InputDecoration(
                                  labelText: 'Blood Pressure',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter blood pressure';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  bloodPressure = value ?? '';
                                },
                              ),
                              SizedBox(height: 8.0),
                              TextFormField(
                                initialValue: bloodOxygenLevel,
                                decoration: InputDecoration(
                                  labelText: 'Blood Oxygen Level',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter blood oxygen level';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  bloodOxygenLevel = value ?? '';
                                },
                              ),
                              SizedBox(height: 8.0),
                              TextFormField(
                                initialValue: heartbeatRate,
                                decoration: InputDecoration(
                                  labelText: 'Heartbeat Rate',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter heartbeat rate';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  heartbeatRate = value ?? '';
                                },
                              ),
                              SizedBox(height: 8.0),
                              TextFormField(
                                initialValue: height,
                                decoration: InputDecoration(
                                  labelText: 'Height (in cm)',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter height';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  height = value ?? '';
                                },
                              ),
                              SizedBox(height: 8.0),
                              TextFormField(
                                initialValue: weight,
                                decoration: InputDecoration(
                                  labelText: 'Weight (in kg)',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter weight';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  weight = value ?? '';
                                },
                              ),
                              SizedBox(height: 24.0),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    _submitForm();
                                  }
                                },
                                child: Text('Save'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("User doesn't have any record."),
                      if (showAddRecordButton)
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to the page to add a new record
                          },
                          child: const Text('Add Record'),
                        ),
                    ],
                  ),
                ),
    );
  }

  void _submitForm() {
    // TODO: Implement form submission logic
  }
}
