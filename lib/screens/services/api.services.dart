import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patient_app/models/patient.dart';

class APIService {
  static const endpoint = 'http://192.168.0.20:8080/api';

  // method to get all patients
  Future<List<Patient>> getPatients() async {
    const url = "$endpoint/patients";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> patientsJson = json.decode(response.body);
      return patientsJson.map((json) => Patient.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load patients');
    }
  }

  // method to add patient
  Future<Patient> addPatient({
    required String firstName,
    required String lastName,
    required String address,
    required String dateOfBirth,
    required String department,
    required String doctor,
  }) async {
    const url = "$endpoint/patients";
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'first_name': firstName,
        'last_name': lastName,
        'address': address,
        'date_of_birth': dateOfBirth,
        'department': department,
        'doctor': doctor,
      }),
    );

    if (response.statusCode == 201) {
      final dynamic patientJson = json.decode(response.body);
      print(patientJson);
      return Patient.fromJson(patientJson);
    } else {
      throw Exception('Failed to add patient');
    }
  }

  // method to delete patient
  Future<bool> deletePatient(String id) async {
    final url = Uri.parse('$endpoint/patients/$id');
    final response = await http.delete(url);
    if (response.statusCode != 200) {
      throw Exception('Failed to delete patient record');
    }
    return true;
  }
}
