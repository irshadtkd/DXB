import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../data/orders_repository.dart';

sealed class OrdersListState extends Equatable {
  const OrdersListState();
  @override
  List<Object?> get props => [];
}

class OrdersListInitial extends OrdersListState {
  const OrdersListInitial();
}

class OrdersListLoading extends OrdersListState {
  const OrdersListLoading();
}

class OrdersListLoaded extends OrdersListState {
  const OrdersListLoaded(this.orders);
  final List<dynamic> orders;
  @override
  List<Object?> get props => [orders];
}

class OrdersListEmpty extends OrdersListState {
  const OrdersListEmpty();
}

class OrdersListFailure extends OrdersListState {
  const OrdersListFailure(this.failure);
  final Failure failure;
  @override
  List<Object?> get props => [failure];
}

class OrdersListCubit extends Cubit<OrdersListState> {
  OrdersListCubit(this._repo) : super(const OrdersListInitial());
  final OrdersRepository _repo;

  Future<void> load() async {
    emit(const OrdersListLoading());
    try {
      final list = await _repo.fetchOrders();
      if (list.isEmpty) {
        emit(const OrdersListEmpty());
      } else {
        emit(OrdersListLoaded(list));
      }
    } catch (e) {
      emit(OrdersListFailure(mapExceptionToFailure(e)));
    }
  }
}
