import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../data/earnings_repository.dart';

sealed class EarningsState extends Equatable {
  const EarningsState();
  @override
  List<Object?> get props => [];
}

class EarningsInitial extends EarningsState {
  const EarningsInitial();
}

class EarningsLoading extends EarningsState {
  const EarningsLoading();
}

class EarningsLoaded extends EarningsState {
  const EarningsLoaded(this.data);
  final Map<String, dynamic> data;
  @override
  List<Object?> get props => [data];
}

class EarningsFailure extends EarningsState {
  const EarningsFailure(this.failure);
  final Failure failure;
  @override
  List<Object?> get props => [failure];
}

class EarningsCubit extends Cubit<EarningsState> {
  EarningsCubit(this._repo) : super(const EarningsInitial());
  final EarningsRepository _repo;

  Future<void> load() async {
    emit(const EarningsLoading());
    try {
      emit(EarningsLoaded(await _repo.fetchEarnings()));
    } catch (e) {
      emit(EarningsFailure(mapExceptionToFailure(e)));
    }
  }
}

sealed class PayoutsState extends Equatable {
  const PayoutsState();
  @override
  List<Object?> get props => [];
}

class PayoutsInitial extends PayoutsState {
  const PayoutsInitial();
}

class PayoutsLoading extends PayoutsState {
  const PayoutsLoading();
}

class PayoutsLoaded extends PayoutsState {
  const PayoutsLoaded(this.items);
  final List<dynamic> items;
  @override
  List<Object?> get props => [items];
}

class PayoutsFailure extends PayoutsState {
  const PayoutsFailure(this.failure);
  final Failure failure;
  @override
  List<Object?> get props => [failure];
}

class PayoutsCubit extends Cubit<PayoutsState> {
  PayoutsCubit(this._repo) : super(const PayoutsInitial());
  final EarningsRepository _repo;

  Future<void> load() async {
    emit(const PayoutsLoading());
    try {
      emit(PayoutsLoaded(await _repo.fetchPayouts()));
    } catch (e) {
      emit(PayoutsFailure(mapExceptionToFailure(e)));
    }
  }
}

sealed class BankState extends Equatable {
  const BankState();
  @override
  List<Object?> get props => [];
}

class BankInitial extends BankState {
  const BankInitial();
}

class BankLoading extends BankState {
  const BankLoading();
}

class BankLoaded extends BankState {
  const BankLoaded(this.data);
  final Map<String, dynamic> data;
  @override
  List<Object?> get props => [data];
}

class BankFailure extends BankState {
  const BankFailure(this.failure);
  final Failure failure;
  @override
  List<Object?> get props => [failure];
}

class BankCubit extends Cubit<BankState> {
  BankCubit(this._repo) : super(const BankInitial());
  final EarningsRepository _repo;

  Future<void> load() async {
    emit(const BankLoading());
    try {
      emit(BankLoaded(await _repo.fetchBank()));
    } catch (e) {
      emit(BankFailure(mapExceptionToFailure(e)));
    }
  }
}
