import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../data/customers_repository.dart';

sealed class CustomerDetailState extends Equatable {
  const CustomerDetailState();
  @override
  List<Object?> get props => [];
}

class CustomerDetailInitial extends CustomerDetailState {
  const CustomerDetailInitial();
}

class CustomerDetailLoading extends CustomerDetailState {
  const CustomerDetailLoading();
}

class CustomerDetailLoaded extends CustomerDetailState {
  const CustomerDetailLoaded(this.data);
  final Map<String, dynamic> data;
  @override
  List<Object?> get props => [data];
}

class CustomerDetailFailure extends CustomerDetailState {
  const CustomerDetailFailure(this.failure);
  final Failure failure;
  @override
  List<Object?> get props => [failure];
}

class CustomerDetailEmpty extends CustomerDetailState {
  const CustomerDetailEmpty();
}

class CustomerDetailCubit extends Cubit<CustomerDetailState> {
  CustomerDetailCubit(this._repo) : super(const CustomerDetailInitial());
  final CustomersRepository _repo;

  Future<void> load(String id) async {
    emit(const CustomerDetailLoading());
    try {
      final data = await _repo.fetchCustomer(id);
      if (data == null) {
        emit(const CustomerDetailEmpty());
      } else {
        emit(CustomerDetailLoaded(data));
      }
    } catch (e) {
      emit(CustomerDetailFailure(mapExceptionToFailure(e)));
    }
  }
}
