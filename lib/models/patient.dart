class Patient {
  String firstName;
  String lastName;
  String address;
  String dateOfBirth;
  String department;
  String doctor;

  Patient({
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.dateOfBirth,
    required this.department,
    required this.doctor,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
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
      'first_name': firstName,
      'last_name': lastName,
      'address': address,
      'date_of_birth': dateOfBirth,
      'department': department,
      'doctor': doctor,
    };
  }
}
