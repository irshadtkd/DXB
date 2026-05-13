import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../data/customers_repository.dart';

sealed class CustomersListState extends Equatable {
  const CustomersListState();
  @override
  List<Object?> get props => [];
}

class CustomersListInitial extends CustomersListState {
  const CustomersListInitial();
}

class CustomersListLoading extends CustomersListState {
  const CustomersListLoading();
}

class CustomersListLoaded extends CustomersListState {
  const CustomersListLoaded(this.items);
  final List<dynamic> items;
  @override
  List<Object?> get props => [items];
}

class CustomersListEmpty extends CustomersListState {
  const CustomersListEmpty();
}

class CustomersListFailure extends CustomersListState {
  const CustomersListFailure(this.failure);
  final Failure failure;
  @override
  List<Object?> get props => [failure];
}

class CustomersListCubit extends Cubit<CustomersListState> {
  CustomersListCubit(this._repo) : super(const CustomersListInitial());
  final CustomersRepository _repo;

  Future<void> load() async {
    emit(const CustomersListLoading());
    try {
      final list = await _repo.fetchCustomers();
      if (list.isEmpty) {
        emit(const CustomersListEmpty());
      } else {
        emit(CustomersListLoaded(list));
      }
    } catch (e) {
      emit(CustomersListFailure(mapExceptionToFailure(e)));
    }
  }
}
