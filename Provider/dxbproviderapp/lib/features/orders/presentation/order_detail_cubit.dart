import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../data/orders_repository.dart';

sealed class OrderDetailState extends Equatable {
  const OrderDetailState();
  @override
  List<Object?> get props => [];
}

class OrderDetailInitial extends OrderDetailState {
  const OrderDetailInitial();
}

class OrderDetailLoading extends OrderDetailState {
  const OrderDetailLoading();
}

class OrderDetailLoaded extends OrderDetailState {
  const OrderDetailLoaded(this.data);
  final Map<String, dynamic> data;
  @override
  List<Object?> get props => [data];
}

class OrderDetailFailure extends OrderDetailState {
  const OrderDetailFailure(this.failure);
  final Failure failure;
  @override
  List<Object?> get props => [failure];
}

class OrderDetailCubit extends Cubit<OrderDetailState> {
  OrderDetailCubit(this._repo) : super(const OrderDetailInitial());
  final OrdersRepository _repo;

  Future<void> load(String id) async {
    emit(const OrderDetailLoading());
    try {
      final data = await _repo.fetchOrderDetail(id);
      emit(OrderDetailLoaded(data));
    } catch (e) {
      emit(OrderDetailFailure(mapExceptionToFailure(e)));
    }
  }
}
