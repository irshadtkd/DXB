import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/util/load_status.dart';
import '../../../../domain/entities/entities.dart';
import '../../../../domain/usecases/usecases.dart';

class LaundryHomeState extends Equatable {
  const LaundryHomeState({required this.status, this.data, this.message});

  final LoadStatus status;
  final LaundryHomeData? data;
  final String? message;

  LaundryHomeState copyWith({LoadStatus? status, LaundryHomeData? data, String? message}) =>
      LaundryHomeState(status: status ?? this.status, data: data ?? this.data, message: message ?? this.message);

  @override
  List<Object?> get props => [status, data, message];
}

class LaundryHomeCubit extends Cubit<LaundryHomeState> {
  LaundryHomeCubit(this._uc) : super(const LaundryHomeState(status: LoadStatus.initial));
  final GetLaundryHome _uc;

  Future<void> load() async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      final d = await _uc();
      emit(LaundryHomeState(status: LoadStatus.success, data: d));
    } catch (_) {
      emit(state.copyWith(status: LoadStatus.failure, message: AppStrings.networkError));
    }
  }

  Future<void> retry() => load();
}
