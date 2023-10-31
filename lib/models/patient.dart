class Patient {
  int? id;
  String lastname;
  String? firstname;
  int age;
  Sex sex;
  OperationType operationType;
  AnesthesiaType anesthesiaType;
  String telephone;
  Observation observation;
  String? comment;
  String? address;
  DateTime? birthDate;

  Patient(
      {this.id,
      required this.lastname,
      this.firstname,
      required this.age,
      required this.sex,
      required this.operationType,
      required this.anesthesiaType,
      required this.telephone,
      required this.observation,
      this.comment,
      this.address,
      this.birthDate});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'lastname': lastname,
      'firstname': firstname,
      'age': age,
      'sex': sex,
      'operationType': operationType,
      'anesthesiaType': anesthesiaType,
      'telephone': telephone,
      'observation': observation,
      'comment': comment,
      'address': address,
      'birthDate': birthDate?.toIso8601String(),
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory Patient.fromMap(Map<String, dynamic> data) {
    return Patient(
      id: data['id'],
      lastname: data['lastname'],
      firstname: data['firstname'],
      age: data['age'],
      sex: data['sex'],
      operationType: data['operationType'],
      anesthesiaType: data['anesthesiaType'],
      telephone: data['telephone'],
      observation: data['observation'],
      comment: data['comment'],
      address: data['address'],
      birthDate: DateTime.parse(data['birthDate']),
    );
  }
}

enum Sex { male, female }

enum OperationType {
  flg,
  fld,
  flpg,
  hisd,
  hisg,
  lipome,
  hydrocele,
  kyste,
  brulure,
  other
}

enum AnesthesiaType { local, general, other }

enum Observation { able, unable, other }
