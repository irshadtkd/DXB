import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../data/analytics_repository.dart';

sealed class AnalyticsOverviewState extends Equatable {
  const AnalyticsOverviewState();
  @override
  List<Object?> get props => [];
}

class AnalyticsOverviewInitial extends AnalyticsOverviewState {
  const AnalyticsOverviewInitial();
}

class AnalyticsOverviewLoading extends AnalyticsOverviewState {
  const AnalyticsOverviewLoading();
}

class AnalyticsOverviewLoaded extends AnalyticsOverviewState {
  const AnalyticsOverviewLoaded(this.data);
  final Map<String, dynamic> data;
  @override
  List<Object?> get props => [data];
}

class AnalyticsOverviewFailure extends AnalyticsOverviewState {
  const AnalyticsOverviewFailure(this.failure);
  final Failure failure;
  @override
  List<Object?> get props => [failure];
}

class AnalyticsOverviewCubit extends Cubit<AnalyticsOverviewState> {
  AnalyticsOverviewCubit(this._repo) : super(const AnalyticsOverviewInitial());
  final AnalyticsRepository _repo;

  Future<void> load() async {
    emit(const AnalyticsOverviewLoading());
    try {
      emit(AnalyticsOverviewLoaded(await _repo.overview()));
    } catch (e) {
      emit(AnalyticsOverviewFailure(mapExceptionToFailure(e)));
    }
  }
}

sealed class AnalyticsVerticalState extends Equatable {
  const AnalyticsVerticalState();
  @override
  List<Object?> get props => [];
}

class AnalyticsVerticalInitial extends AnalyticsVerticalState {
  const AnalyticsVerticalInitial();
}

class AnalyticsVerticalLoading extends AnalyticsVerticalState {
  const AnalyticsVerticalLoading();
}

class AnalyticsVerticalLoaded extends AnalyticsVerticalState {
  const AnalyticsVerticalLoaded(this.data);
  final Map<String, dynamic> data;
  @override
  List<Object?> get props => [data];
}

class AnalyticsVerticalFailure extends AnalyticsVerticalState {
  const AnalyticsVerticalFailure(this.failure);
  final Failure failure;
  @override
  List<Object?> get props => [failure];
}

class AnalyticsVerticalCubit extends Cubit<AnalyticsVerticalState> {
  AnalyticsVerticalCubit(this._repo) : super(const AnalyticsVerticalInitial());
  final AnalyticsRepository _repo;

  Future<void> load() async {
    emit(const AnalyticsVerticalLoading());
    try {
      emit(AnalyticsVerticalLoaded(await _repo.vertical()));
    } catch (e) {
      emit(AnalyticsVerticalFailure(mapExceptionToFailure(e)));
    }
  }
}

sealed class AnalyticsOperationalState extends Equatable {
  const AnalyticsOperationalState();
  @override
  List<Object?> get props => [];
}

class AnalyticsOperationalInitial extends AnalyticsOperationalState {
  const AnalyticsOperationalInitial();
}

class AnalyticsOperationalLoading extends AnalyticsOperationalState {
  const AnalyticsOperationalLoading();
}

class AnalyticsOperationalLoaded extends AnalyticsOperationalState {
  const AnalyticsOperationalLoaded(this.data);
  final Map<String, dynamic> data;
  @override
  List<Object?> get props => [data];
}

class AnalyticsOperationalFailure extends AnalyticsOperationalState {
  const AnalyticsOperationalFailure(this.failure);
  final Failure failure;
  @override
  List<Object?> get props => [failure];
}

class AnalyticsOperationalCubit extends Cubit<AnalyticsOperationalState> {
  AnalyticsOperationalCubit(this._repo) : super(const AnalyticsOperationalInitial());
  final AnalyticsRepository _repo;

  Future<void> load() async {
    emit(const AnalyticsOperationalLoading());
    try {
      emit(AnalyticsOperationalLoaded(await _repo.operational()));
    } catch (e) {
      emit(AnalyticsOperationalFailure(mapExceptionToFailure(e)));
    }
  }
}
