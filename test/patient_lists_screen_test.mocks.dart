// Mocks generated by Mockito 5.4.0 from annotations
// in patient_app/test/patient_lists_screen_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:patient_app/models/patient.dart' as _i2;
import 'package:patient_app/screens/services/api.services.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakePatient_0 extends _i1.SmartFake implements _i2.Patient {
  _FakePatient_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [APIService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAPIService extends _i1.Mock implements _i3.APIService {
  MockAPIService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i2.Patient>> getPatients() => (super.noSuchMethod(
        Invocation.method(
          #getPatients,
          [],
        ),
        returnValue: _i4.Future<List<_i2.Patient>>.value(<_i2.Patient>[]),
      ) as _i4.Future<List<_i2.Patient>>);
  @override
  _i4.Future<_i2.Patient> addPatient({
    required String? firstName,
    required String? lastName,
    required String? address,
    required String? dateOfBirth,
    required String? department,
    required String? doctor,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #addPatient,
          [],
          {
            #firstName: firstName,
            #lastName: lastName,
            #address: address,
            #dateOfBirth: dateOfBirth,
            #department: department,
            #doctor: doctor,
          },
        ),
        returnValue: _i4.Future<_i2.Patient>.value(_FakePatient_0(
          this,
          Invocation.method(
            #addPatient,
            [],
            {
              #firstName: firstName,
              #lastName: lastName,
              #address: address,
              #dateOfBirth: dateOfBirth,
              #department: department,
              #doctor: doctor,
            },
          ),
        )),
      ) as _i4.Future<_i2.Patient>);
  @override
  _i4.Future<_i2.Patient> updatePatient({
    required dynamic id,
    required String? firstName,
    required String? lastName,
    required String? address,
    required String? dateOfBirth,
    required String? department,
    required String? doctor,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #updatePatient,
          [],
          {
            #id: id,
            #firstName: firstName,
            #lastName: lastName,
            #address: address,
            #dateOfBirth: dateOfBirth,
            #department: department,
            #doctor: doctor,
          },
        ),
        returnValue: _i4.Future<_i2.Patient>.value(_FakePatient_0(
          this,
          Invocation.method(
            #updatePatient,
            [],
            {
              #id: id,
              #firstName: firstName,
              #lastName: lastName,
              #address: address,
              #dateOfBirth: dateOfBirth,
              #department: department,
              #doctor: doctor,
            },
          ),
        )),
      ) as _i4.Future<_i2.Patient>);
  @override
  _i4.Future<bool> deletePatient(String? id) => (super.noSuchMethod(
        Invocation.method(
          #deletePatient,
          [id],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<Map<String, dynamic>> getPatientRecords(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPatientRecords,
          [id],
        ),
        returnValue:
            _i4.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i4.Future<Map<String, dynamic>>);
  @override
  _i4.Future<List<Map<String, dynamic>>> getAllPatientRecords() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllPatientRecords,
          [],
        ),
        returnValue: _i4.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i4.Future<List<Map<String, dynamic>>>);
  @override
  _i4.Future<Map<String, dynamic>> addPatientRecord({
    required String? id,
    required String? date,
    required String? nurseName,
    required double? bloodPressure,
    required double? bloodOxygenLevel,
    required double? heartbeatRate,
    required double? height,
    required double? weight,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #addPatientRecord,
          [],
          {
            #id: id,
            #date: date,
            #nurseName: nurseName,
            #bloodPressure: bloodPressure,
            #bloodOxygenLevel: bloodOxygenLevel,
            #heartbeatRate: heartbeatRate,
            #height: height,
            #weight: weight,
          },
        ),
        returnValue:
            _i4.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i4.Future<Map<String, dynamic>>);
  @override
  _i4.Future<Map<String, dynamic>> updatePatientRecord({
    required String? id,
    String? date,
    String? nurseName,
    String? bloodPressure,
    String? bloodOxygenLevel,
    String? heartbeatRate,
    String? height,
    String? weight,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #updatePatientRecord,
          [],
          {
            #id: id,
            #date: date,
            #nurseName: nurseName,
            #bloodPressure: bloodPressure,
            #bloodOxygenLevel: bloodOxygenLevel,
            #heartbeatRate: heartbeatRate,
            #height: height,
            #weight: weight,
          },
        ),
        returnValue:
            _i4.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i4.Future<Map<String, dynamic>>);
  @override
  _i4.Future<void> deletePatientRecord(String? id) => (super.noSuchMethod(
        Invocation.method(
          #deletePatientRecord,
          [id],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
