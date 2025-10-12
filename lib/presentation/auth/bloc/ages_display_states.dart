import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecome_clean/core/utils/constants/tydefs.dart';

abstract class AgesDisplayState {}

class AgesLoading extends AgesDisplayState {}

class AgesLoaded extends AgesDisplayState {
  final List<QueryDocumentSnapshot<DataMap>> ages;

  AgesLoaded({required this.ages});
}

class AgesLoadFailure extends AgesDisplayState {
  final String message;

  AgesLoadFailure({required this.message});
}
