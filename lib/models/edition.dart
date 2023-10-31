class Edition {
  int id;
  int year;
  String city;

  Edition(this.id, this.year, this.city);

  //convertir le wish list en fromMap
  Edition.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        year = map['year'],
        city = map['city'];
}
