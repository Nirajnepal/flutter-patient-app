import 'package:flutter/material.dart';
import 'package:patient_app/models/patient.dart';
import 'package:patient_app/models/user.dart';
import 'package:patient_app/screens/home_screen.dart';
import 'package:patient_app/screens/auth/login_screen.dart';
import 'package:patient_app/screens/auth/register_screen.dart';
import 'package:patient_app/screens/patient/patient_detail_screen.dart';
import 'package:patient_app/screens/patient/patient_lists_screen.dart';
import 'package:patient_app/screens/patient/add_patient_details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Patient patientData = Patient(
    id: '',
    firstName: '',
    lastName: '',
    dateOfBirth: '',
    address: '',
    department: '',
    doctor: '',
  );

  User user = User(
    fullName: '',
    email: '',
    password: '',
  );

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patient Clinical Data Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: navigatorKey,
      initialRoute: '/login',
      routes: {
        '/home': (context) => HomeScreen(
              user: user,
            ),
        '/': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/patients': (context) => const PatientListScreen(),
        '/patient_detail': (context) =>
            PatientDetailScreen(patient: patientData),
        '/add_patient': (context) => const AddPatientScreen(),
      },
    );
  }
}
