import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/util/load_status.dart';
import '../../../../domain/entities/entities.dart';
import '../../../../domain/usecases/usecases.dart';

class OrdersState extends Equatable {
  const OrdersState({
    required this.status,
    this.orders = const [],
    this.message,
    this.filter = 'all',
  });

  final LoadStatus status;
  final List<OrderHistoryItem> orders;
  final String? message;
  final String filter;

  OrdersState copyWith({
    LoadStatus? status,
    List<OrderHistoryItem>? orders,
    String? message,
    String? filter,
  }) {
    return OrdersState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      message: message ?? this.message,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [status, orders, message, filter];
}

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this._getOrderHistory) : super(const OrdersState(status: LoadStatus.initial));

  final GetOrderHistory _getOrderHistory;

  Future<void> load() async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      final list = await _getOrderHistory();
      emit(OrdersState(status: LoadStatus.success, orders: list, filter: state.filter));
    } catch (_) {
      emit(state.copyWith(status: LoadStatus.failure, message: AppStrings.networkError));
    }
  }

  void setFilter(String f) => emit(state.copyWith(filter: f));

  List<OrderHistoryItem> get filtered {
    if (state.filter == 'all') return state.orders;
    return state.orders.where((o) => o.category == state.filter).toList();
  }

  Future<void> retry() => load();
}
