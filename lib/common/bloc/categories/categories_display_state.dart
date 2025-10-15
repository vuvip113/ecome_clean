part of 'categories_display_cubit.dart';

abstract class CategoriesDisplayState extends Equatable {
  const CategoriesDisplayState();

  @override
  List<Object> get props => [];
}

class CategoriesDisplayInitial extends CategoriesDisplayState {}

class CategoriesDisplayLoading extends CategoriesDisplayState {}

class CategoriesDisplayLoaded extends CategoriesDisplayState {
  final List<Category> categories; // Example property

  const CategoriesDisplayLoaded({required this.categories});

  @override
  List<Object> get props => [categories];
}

class CategoriesDisplayError extends CategoriesDisplayState {
  final String message;

  const CategoriesDisplayError({required this.message});

  @override
  List<Object> get props => [message];
}
