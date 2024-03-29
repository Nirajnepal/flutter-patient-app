import 'package:flutter/material.dart';
import 'package:patient_app/screens/services/api.services.dart';
import '../../models/patient.dart';
import 'patient_detail_screen.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({Key? key}) : super(key: key);

  @override
  _PatientListScreenState createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  final APIService apiService = APIService();
  late Future<List<Patient>> _patientsFuture;

  @override
  void initState() {
    super.initState();
    _fetchPatients();
  }

  void _fetchPatients() {
    _patientsFuture = apiService.getPatients();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _fetchPatients();
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient List'),
      ),
      body: FutureBuilder<List<Patient>>(
        future: _patientsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final patients = snapshot.data!;
            return ListView.builder(
              itemCount: patients.length,
              itemBuilder: (context, index) {
                final patient = patients[index];
                //
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PatientDetailScreen(
                          patient: patient,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Image.asset(
                          "assets/user.png",
                          height: 60,
                          width: 60,
                        ),
                      ),
                      title: Text(
                        '${patient.firstName} ${patient.lastName}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            'Date of Birth: ${patient.dateOfBirth}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                      trailing: patient.critical == true
                          ? const Icon(
                              Icons.warning,
                              color: Colors.red,
                              size: 32,
                            )
                          : null,
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
