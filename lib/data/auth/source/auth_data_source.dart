import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecome_clean/core/errors/exception.dart';
import 'package:ecome_clean/data/auth/models/user_model.dart';
import 'package:ecome_clean/domain/auth/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthDataSource {
  const AuthDataSource();
  Future<void> signUp(UserEntity user);
  Future<void> signIn(UserEntity user);
  Future<List<String>> getAges();
  Future<void> resetPassword(String email);
  Future<bool> isLoggedIn();
  Future<UserModel> getUser();
  Future<void> signOut();
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

  @override
  Future<void> signIn(UserEntity user) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else {
        errorMessage = 'An undefined Error happened.';
      }
      throw ServerException(massage: errorMessage, statusCode: 404);
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else {
        errorMessage = 'An undefined Error happened.';
      }
      throw ServerException(massage: errorMessage, statusCode: 404);
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    if (FirebaseAuth.instance.currentUser != null) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  @override
  Future<UserModel> getUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      final snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user?.uid)
          .get();

      final data = snapshot.data();
      if (data == null) {
        throw const ServerException(
          massage: 'User data not found',
          statusCode: 404,
        );
      }

      final userModel = UserModel.fromMap(data);

      return userModel;
    } catch (e) {
      throw ServerException(massage: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        massage: e.message ?? 'Failed to sign out.',
        statusCode: 500,
      );
    }
  }
}
