import 'package:faker/faker.dart';
import 'package:flutter/widgets.dart';

class User {
  final String id;
  final String name, email;
  final int age;

  User({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.age,
  });

  static User fake() {
    return User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: faker.person.name(),
      email: faker.internet.email(),
      age: RandomGenerator().integer(100, min: 18),
    );
  }

  static User fromJson(Map<String, dynamic> map) {
    return User(
      id: map["id"],
      name: map["name"],
      email: map["email"],
      age: map["age"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "email": this.email,
      "age": this.age
    };
  }
}
