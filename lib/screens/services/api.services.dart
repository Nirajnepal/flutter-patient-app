import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patient_app/models/patient.dart';

class APIService {
  static const endpoint = 'http://192.168.2.49:8080/api';

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
      print('Patient: $patientJson');
      return Patient.fromJson(patientJson);
    } else {
      throw Exception('Failed to add patient');
    }
  }

  // method to update patient
  Future<Patient> updatePatient({
    required id,
    required String firstName,
    required String lastName,
    required String address,
    required String dateOfBirth,
    required String department,
    required String doctor,
  }) async {
    final url = Uri.parse('$endpoint/patients/$id');
    final response = await http.patch(
      url,
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

    if (response.statusCode == 200) {
      final dynamic patientJson = json.decode(response.body);
      return Patient.fromJson(patientJson);
    } else {
      throw Exception('Failed to update patient');
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

  Future<Map<String, dynamic>> getPatientRecords(String id) async {
    final response =
        await http.get(Uri.parse('$endpoint/patients/$id/records'));
    // print(response.body);

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return responseBody;
    } else if (response.statusCode == 404) {
      return {"message": "Cannot find patient record"};
    } else {
      throw Exception('Failed to get patient records');
    }
  }

  // Get All Patient Records
  Future<List<Map<String, dynamic>>> getAllPatientRecords() async {
    final response = await http.get(Uri.parse('$endpoint/records'));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return List<Map<String, dynamic>>.from(responseBody);
    } else {
      throw Exception('Failed to get all patient records');
    }
  }

  // Add Patient Record
  Future<Map<String, dynamic>> addPatientRecord({
    required String id,
    required String date,
    required String nurseName,
    required double bloodPressure,
    required double bloodOxygenLevel,
    required double heartbeatRate,
    required double height,
    required double weight,
  }) async {
    final response = await http.post(
      Uri.parse('$endpoint/patients/$id/records'),
      body: {
        'date': date,
        'nurse_name': nurseName,
        'blood_pressure': bloodPressure.toString(),
        'blood_oxygen_level': bloodOxygenLevel.toString(),
        'heartbeat_rate': heartbeatRate.toString(),
        'height': height.toString(),
        'weight': weight.toString(),
      },
    );

    if (response.statusCode == 201) {
      final responseBody = json.decode(response.body);
      return responseBody;
    } else {
      throw Exception('Failed to add patient record');
    }
  }

  // Updating Patient Record
  Future<Map<String, dynamic>> updatePatientRecord({
    required String id,
    String? date,
    String? nurseName,
    double? bloodPressure,
    double? bloodOxygenLevel,
    double? heartbeatRate,
    double? height,
    double? weight,
  }) async {
    final response = await http.patch(
      Uri.parse('$endpoint/patients/$id/records'),
      body: {
        if (date != null) 'date': date,
        if (nurseName != null) 'nurse_name': nurseName,
        if (bloodPressure != null) 'blood_pressure': bloodPressure.toString(),
        if (bloodOxygenLevel != null)
          'blood_oxygen_level': bloodOxygenLevel.toString(),
        if (heartbeatRate != null) 'heartbeat_rate': heartbeatRate.toString(),
        if (height != null) 'height': height.toString(),
        if (weight != null) 'weight': weight.toString(),
      },
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return responseBody;
    } else {
      throw Exception('Failed to update patient record');
    }
  }

  // Deleting Patient Record
  Future<void> deletePatientRecord(String id) async {
    final response =
        await http.delete(Uri.parse('$endpoint/patients/$id/records'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete patient record');
    }
  }
}
