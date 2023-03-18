class Patient {
  String? id;
  String firstName;
  String lastName;
  String address;
  String dateOfBirth;
  String department;
  String doctor;

  Patient({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.dateOfBirth,
    required this.department,
    required this.doctor,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      address: json['address'],
      dateOfBirth: json['date_of_birth'],
      department: json['department'],
      doctor: json['doctor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'first_name': firstName,
      'last_name': lastName,
      'address': address,
      'date_of_birth': dateOfBirth,
      'department': department,
      'doctor': doctor,
    };
  }

  @override
  String toString() {
    return 'Patient: { _id: $id, $firstName, lastName: $lastName, dateOfBirth: $dateOfBirth, address: $address, department: $department, doctor: $doctor }';
  }
}
