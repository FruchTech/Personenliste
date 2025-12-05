import 'dart:convert';

class Person {
  String vorname;
  String nachname;
  String email;
  int alter;
  String picture;

  Person({
    required this.vorname,
    required this.nachname,
    required this.email,
    required this.alter,
    String? picture,
  }) : picture = (picture == null || picture.isEmpty)
           ? "assets/img/placeholder.png"
           : picture;

  String toJSON() {
    Map<String, dynamic> map = <String, dynamic>{};

    map["nachname"] = nachname;
    map["vorname"] = vorname;
    map["email"] = email;
    map["alter"] = alter;
    map["picture"] = picture;

    return jsonEncode(map);
  }

  static Person fromJSON(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    return Person(
      nachname: map["nachname"],
      vorname: map["vorname"],
      email: map["email"],
      alter: map["alter"],
      picture: map["picture"],
    );
  }
}
