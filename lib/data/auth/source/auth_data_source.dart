import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecome_clean/core/errors/exception.dart';
import 'package:ecome_clean/domain/auth/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthDataSource {
  const AuthDataSource();
  Future<void> signUp(UserEntity user);
  Future<List<String>> getAges();
}

class AuthDataSourceImpl implements AuthDataSource {
  @override
  Future<void> signUp(UserEntity user) async {
    try {
      var returnedData = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email!,
            password: user.password!,
          );
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(returnedData.user?.uid)
          .set({
            'userId': returnedData.user?.uid,
            'firstName': user.firstName,
            'lastName': user.lastName,
            'email': user.email,
            'gender': user.gender,
            'age': user.age,
          });
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else {
        errorMessage = 'An undefined Error happened.';
      }
      throw ServerException(massage: errorMessage, statusCode: 404);
    }
  }

  @override
  Future<List<String>> getAges() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Ages')
          .get();
      return snapshot.docs.map((doc) => doc['label'] as String).toList();
    } on FirebaseException catch (e) {
      throw ServerException(
        massage: e.message ?? 'Failed to fetch ages',
        statusCode: 500,
      );
    }
  }
}
