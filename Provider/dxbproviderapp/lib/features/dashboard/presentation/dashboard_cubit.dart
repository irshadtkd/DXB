import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../data/dashboard_repository.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

class DashboardLoaded extends DashboardState {
  const DashboardLoaded(this.data);
  final Map<String, dynamic> data;

  @override
  List<Object?> get props => [data];
}

class DashboardFailure extends DashboardState {
  const DashboardFailure(this.failure);
  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(this._repo) : super(const DashboardInitial());

  final DashboardRepository _repo;

  Future<void> load() async {
    emit(const DashboardLoading());
    try {
      final data = await _repo.fetchDashboard();
      emit(DashboardLoaded(data));
    } catch (e) {
      emit(DashboardFailure(mapExceptionToFailure(e)));
    }
  }
}
