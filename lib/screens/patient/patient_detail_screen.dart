import 'package:flutter/material.dart';
import '../../models/patient.dart';

class PatientDetailScreen extends StatelessWidget {
  final Patient patient;

  const PatientDetailScreen({Key? key, required this.patient})
      : super(key: key);

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
              ListTile(
                title: Text(
                  '${patient.firstName} ${patient.lastName}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                title: Text(
                  'Date of Birth',
                  style: const TextStyle(
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
                title: Text(
                  'Address',
                  style: const TextStyle(
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
                title: Text(
                  'Department',
                  style: const TextStyle(
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
                title: Text(
                  'Doctor',
                  style: const TextStyle(
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
                    onPressed: () {},
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
                    onPressed: () {},
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
