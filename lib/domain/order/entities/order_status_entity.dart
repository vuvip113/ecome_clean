import 'package:equatable/equatable.dart';

class OrderStatusEntity extends Equatable {
  final DateTime createdDate;
  final bool done;
  final String title;

  const OrderStatusEntity({
    required this.createdDate,
    required this.done,
    required this.title,
  });

  @override
  List<Object?> get props => [createdDate, done, title];
}
