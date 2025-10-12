// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ecome_clean/domain/auth/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

class RegisterParams extends Equatable {
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? password;
  final int? gender;
  final String? age;
  const RegisterParams({
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.gender,
    this.age,
  });

  RegisterParams copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? password,
    int? gender,
    String? age,
  }) {
    return RegisterParams(
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      password: password ?? this.password,
      gender: gender ?? this.gender,
      age: age ?? this.age,
    );
  }

  UserEntity toEntity() {
    return UserEntity(email, firstName, lastName, password, gender, age);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'gender': gender,
      'age': age,
    };
  }

  factory RegisterParams.fromMap(Map<String, dynamic> map) {
    return RegisterParams(
      email: map['email'] != null ? map['email'] as String : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      gender: map['gender'] != null ? map['gender'] as int : null,
      age: map['age'] != null ? map['age'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterParams.fromJson(String source) =>
      RegisterParams.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [email, firstName, lastName, password, gender, age];
  }
}
