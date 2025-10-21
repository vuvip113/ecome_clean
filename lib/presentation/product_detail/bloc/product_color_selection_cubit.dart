import 'package:flutter_bloc/flutter_bloc.dart';

class ProductColorSelectionCubit extends Cubit<int> {
  ProductColorSelectionCubit() : super(0);
  int slectedIndex = 0;
  void itemSelection(int index) {
    slectedIndex = index;
    emit(slectedIndex);
  }
}
