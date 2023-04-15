import 'package:flutter/material.dart';
import 'package:patient_app/screens/patient/add_record_sceen.dart';
import 'package:patient_app/screens/services/api.services.dart';
import 'package:patient_app/models/patientrecord.dart';
import 'package:patient_app/models/patient.dart';
import 'package:flutter/services.dart';
import 'patient_detail_screen.dart';

class RecordScreen extends StatefulWidget {
  final String userId;
  final String firstName;
  final Patient patient;

  RecordScreen(
      {required this.userId, required this.firstName, required this.patient});

  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  final _formKey = GlobalKey<FormState>();

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
  String userId = '';
  String firstName = '';

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
        date = record?.date ?? '';
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

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        isLoading = true;
      });
      try {
        await apiService.updatePatientRecord(
          id: widget.userId,
          date: date,
          nurseName: nurseName,
          bloodPressure: bloodPressure,
          bloodOxygenLevel: bloodOxygenLevel,
          heartbeatRate: heartbeatRate,
          height: height,
          weight: weight,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Record saved successfully.'),
          ),
        );

        setState(() {
          isLoading = false;
          hasRecord = true;
          showAddRecordButton = false;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to save record. Please try again later.'),
          ),
        );
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _deleteRecord() async {
    try {
      await apiService.deletePatientRecord(widget.userId);

      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PatientDetailScreen(
              patient: widget.patient,
            ),
          ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to delete record. Please try again later.'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getRecord();
    setState(() {
      userId = widget.userId;
      firstName = widget.firstName;
    });
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
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Card(
                        margin: EdgeInsets.all(16.0),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Patient Name: ${widget.firstName}',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                  IconButton(
                                      icon:
                                          Icon(Icons.delete, color: Colors.red),
                                      onPressed: _deleteRecord),
                                ],
                              ),
                              SizedBox(height: 8.0),
                              TextFormField(
                                initialValue: nurseName,
                                decoration: const InputDecoration(
                                  labelText: 'Nurse Name',
                                ),
                                validator: (val) => val!.isEmpty
                                    ? 'Nurse name is required'
                                    : null,
                                onChanged: (val) {
                                  setState(() {
                                    nurseName = val;
                                  });
                                },
                              ),
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
                                initialValue: date,
                                decoration: const InputDecoration(
                                  labelText: 'Date (YYYY-MM-DD) *',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (val) =>
                                    val!.isEmpty ? 'Date is required' : null,
                                onChanged: (val) {
                                  setState(() {
                                    date = val;
                                  });
                                },
                              ),
                              SizedBox(height: 8.0),
                              TextFormField(
                                initialValue: bloodPressure,
                                decoration: const InputDecoration(
                                  labelText: 'Blood Pressure',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (val) => val!.isEmpty
                                    ? 'Blood Pressure is required'
                                    : null,
                                onChanged: (val) {
                                  setState(() {
                                    bloodPressure = val;
                                  });
                                },
                              ),
                              SizedBox(height: 8.0),
                              TextFormField(
                                initialValue: bloodOxygenLevel,
                                decoration: const InputDecoration(
                                  labelText: 'Blood Oxygen Level',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (val) => val!.isEmpty
                                    ? 'Blood Oxygen Level is required'
                                    : null,
                                onSaved: (val) => bloodOxygenLevel = val!,
                              ),
                              SizedBox(height: 8.0),
                              TextFormField(
                                initialValue: heartbeatRate,
                                decoration: const InputDecoration(
                                  labelText: 'Heartbeat Rate',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (val) => val!.isEmpty
                                    ? 'Heartbeat Rate is required'
                                    : null,
                                onSaved: (val) => heartbeatRate = val!,
                              ),
                              SizedBox(height: 8.0),
                              TextFormField(
                                initialValue: height,
                                decoration: const InputDecoration(
                                  labelText: 'Height (in cm)',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (val) =>
                                    val!.isEmpty ? 'Height is required' : null,
                                onSaved: (val) => height = val!,
                              ),
                              SizedBox(height: 8.0),
                              TextFormField(
                                initialValue: weight,
                                decoration: const InputDecoration(
                                  labelText: 'Weight (in kg)',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (val) =>
                                    val!.isEmpty ? 'Weight is required' : null,
                                onSaved: (val) => weight = val!,
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
                                      Icon(Icons.edit_document,
                                          color: Colors.white),
                                      SizedBox(width: 10),
                                      Text(
                                        'Update Record',
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
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddRecordScreen(
                                  userId: widget.userId,
                                  firstName: widget.firstName,
                                  patient: widget.patient,
                                ),
                              ),
                              (Route<dynamic> route) => route.isFirst,
                            );
                          },
                          child: const Text('Add Record'),
                        ),
                    ],
                  ),
                ),
    );
  }
}
