import 'package:flutter/material.dart';
import '../../models/patient.dart';
import 'package:patient_app/screens/services/api.services.dart';
import 'patient_update_screen.dart';
import 'record_screen.dart';

class PatientDetailScreen extends StatelessWidget {
  final Patient patient;
  final APIService apiService = APIService();

  PatientDetailScreen({Key? key, required this.patient}) : super(key: key);

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Are you sure you want to delete the patient?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                const Text(
                  'This action is irreversible.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[300],
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // Delete the patient using the API service
                        final result =
                            await apiService.deletePatient(patient.id!);

                        if (result == true) {
                          // Navigate back to the patient list screen
                          Navigator.popUntil(context, ModalRoute.withName('/'));
                        } else {
                          // Display an error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Failed to delete the patient")),
                          );
                        }
                      },
                      child: const Text('Delete'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                child: Center(
                  child: CircleAvatar(
                    radius: 60,
                    child: Image.asset(
                      'assets/user.png',
                      height: 120,
                      width: 120,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${patient.firstName} ${patient.lastName}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecordScreen(
                              userId: patient.id!,
                              firstName: patient.firstName,
                              patient: patient,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.remove_red_eye_sharp),
                      label: Text('Record'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 27, 176, 245),
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Date of Birth',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  '${patient.dateOfBirth}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Address',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  '${patient.address}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Department',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  '${patient.department}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Doctor',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  '${patient.doctor}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Navigate to the update screen with the patient data
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PatientUpdateScreen(
                            patient: patient,
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.edit),
                    label: Text('Edit'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _showDeleteDialog(context);
                    },
                    icon: Icon(Icons.delete),
                    label: Text('Delete'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
