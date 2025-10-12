import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecome_clean/presentation/auth/bloc/ages_display_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgesDisplayCubit extends Cubit<AgesDisplayState> {
  AgesDisplayCubit() : super(AgesLoading());

  Future<void> displayAges() async {
    emit(AgesLoading());
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Ages')
          .get();

      // Emit state chứa danh sách tài liệu
      emit(AgesLoaded(ages: snapshot.docs));
    } on FirebaseException catch (e) {
      emit(
        AgesLoadFailure(message: e.message ?? 'Lỗi tải dữ liệu từ Firestore'),
      );
    } catch (e) {
      emit(AgesLoadFailure(message: 'Lỗi không xác định: $e'));
    }
  }
}
