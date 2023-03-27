class PatientRecord {
  String? id;
  String userId;
  String date;
  String nurseName;
  String bloodPressure;
  String bloodOxygenLevel;
  String heartbeatRate;
  String height;
  String weight;

  PatientRecord({
    this.id,
    required this.userId,
    required this.date,
    required this.nurseName,
    required this.bloodPressure,
    required this.bloodOxygenLevel,
    required this.heartbeatRate,
    required this.height,
    required this.weight,
  });

  factory PatientRecord.fromJson(Map<String, dynamic> json) {
    return PatientRecord(
      id: json['_id'],
      userId: json['user_id'],
      date: json['date'],
      nurseName: json['nurse_name'],
      bloodPressure: json['blood_pressure'],
      bloodOxygenLevel: json['blood_oxygen_level'],
      heartbeatRate: json['heartbeat_rate'],
      height: json['height'],
      weight: json['weight'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user_id': userId,
      'date': date,
      'nurse_name': nurseName,
      'blood_pressure': bloodPressure,
      'blood_oxygen_level': bloodOxygenLevel,
      'heartbeat_rate': heartbeatRate,
      'height': height,
      'weight': weight,
    };
  }

  @override
  String toString() {
    return 'PatientRecord: { _id: $id, userId: $userId, date: $date, nurseName: $nurseName, bloodPressure: $bloodPressure, bloodOxygenLevel: $bloodOxygenLevel, heartbeatRate: $heartbeatRate, height: $height, weight: $weight }';
  }
}
