class Patient {
  final int id;
  final String lastname;
  final String firstname;
  final int age;
  final Sex sex;
  final OperationType operationType;
  final AnesthesiaType anesthesiaType;
  final String telephone;
  final String observation;
  final String comment;
  final String address;
  final DateTime birthDate;

  Patient(
      {required this.id,
      required this.lastname,
      required this.firstname,
      required this.age,
      required this.sex,
      required this.operationType,
      required this.anesthesiaType,
      required this.telephone,
      required this.observation,
      required this.comment,
      required this.address,
      required this.birthDate});
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
