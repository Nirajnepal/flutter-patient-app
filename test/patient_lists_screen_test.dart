import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patient_app/models/patient.dart';
import 'package:patient_app/screens/patient/patient_lists_screen.dart';
import 'package:patient_app/screens/services/api.services.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'dart:io';

import 'patient_lists_screen_test.mocks.dart'; // This line is new

@GenerateMocks([APIService]) // This line is new

void main() {
  setUpAll(() {
    // required to avoid HTTP error 400 mocked returns
    HttpOverrides.global = null;
  });
  // Prepare the mock data
  // List<Patient> patients = [
  //   Patient(
  //       id: "1",
  //       firstName: 'John',
  //       lastName: 'Doe',
  //       dateOfBirth: '01/01/1990',
  //       address: "random",
  //       department: "ICU",
  //       doctor: "Hugh"),
  //   Patient(
  //       id: "2",
  //       firstName: 'Jane',
  //       lastName: 'Doe',
  //       dateOfBirth: '02/02/1992',
  //       address: "random",
  //       department: "ICU",
  //       doctor: "Hugh"),
  // ];

  // group('PatientListScreen', () {
  //   testWidgets('Displays list of patients when data is available',
  //       (WidgetTester tester) async {
  //     // Create a mock instance of APIService
  //     final mockAPIService = MockAPIService();

  //     // Use Mockito to return mock data when getPatients() is called
  //     when(mockAPIService.getPatients()).thenAnswer((_) async => patients);

  //     // Build the PatientListScreen with the mocked APIService
  //     await tester.pumpWidget(
  //       MaterialApp(
  //         home: Provider<APIService>.value(
  //           value: mockAPIService,
  //           child: const PatientListScreen(),
  //         ),
  //       ),
  //     );
  //     await tester.pump();

  //     debugDumpApp();

  //     expect(
  //       find.byType(ListTile),
  //       findsNWidgets(patients.length),
  //     );
  //     expect(
  //       find.widgetWithText(
  //         ListTile,
  //         '${patients[0].firstName} ${patients[0].lastName}',
  //       ),
  //       findsOneWidget,
  //     );
  //     expect(
  //       find.widgetWithText(
  //         ListTile,
  //         '${patients[1].firstName} ${patients[1].lastName}',
  //       ),
  //       findsOneWidget,
  //     );

  //     // Check if the patient names are displayed correctly
  //     for (Patient patient in patients) {
  //       expect(
  //         find.widgetWithText(
  //           ListTile,
  //           '${patient.firstName} ${patient.lastName}',
  //         ),
  //         findsOneWidget,
  //       );
  //     }
  //   });
  // });

  testWidgets('Shows CircularProgressIndicator when loading',
      (WidgetTester tester) async {
    final mockAPIService = MockAPIService();

    // Use Mockito to return an empty list when getPatients() is called
    when(mockAPIService.getPatients()).thenAnswer((_) async => []);

    await tester.pumpWidget(
      MaterialApp(
        home: Provider<APIService>.value(
          value: mockAPIService,
          child: const PatientListScreen(),
        ),
      ),
    );

    // Check if CircularProgressIndicator is shown
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
