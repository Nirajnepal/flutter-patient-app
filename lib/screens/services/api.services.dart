import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patient_app/models/patient.dart';

class APIService {
  static const endpoint = 'http://127.0.0.1:8080/api';

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
}
