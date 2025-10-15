import 'dart:convert';
import 'package:ecome_clean/domain/auth/entities/user_entity.dart';

class UserModel {
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? password;
  final int? gender;
  final String? age;
  final String? image;

  const UserModel({
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.gender,
    this.age,
    this.image,
  });

  // ✅ Chuyển từ Map (Firebase hoặc API) sang Model
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String?,
      firstName: map['firstName'] as String?,
      lastName: map['lastName'] as String?,
      password: map['password'] as String?,
      gender: map['gender'] as int?,
      age: map['age'] as String?,
      image: map['image'] as String?,
    );
  }

  // ✅ Chuyển sang Map (để gửi lên API hoặc Firebase)
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'gender': gender,
      'age': age,
      'image': image,
    };
  }

  // ✅ Parse JSON (khi lưu local hoặc đọc file)
  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  // ✅ Chuyển về Entity (Domain Layer)
  UserEntity toEntity() {
    return UserEntity(email, firstName, lastName, password, gender, age, image);
  }
}
