import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/util/load_status.dart';
import '../../../../domain/entities/entities.dart';
import '../../../../domain/usecases/usecases.dart';

class LaundryTrackingState extends Equatable {
  const LaundryTrackingState({required this.status, this.data, this.message});
  final LoadStatus status;
  final LaundryTrackingData? data;
  final String? message;

  @override
  List<Object?> get props => [status, data, message];
}

class LaundryTrackingCubit extends Cubit<LaundryTrackingState> {
  LaundryTrackingCubit(this._uc, this.orderId) : super(const LaundryTrackingState(status: LoadStatus.initial));
  final GetLaundryTracking _uc;
  final String orderId;

  Future<void> load() async {
    emit(const LaundryTrackingState(status: LoadStatus.loading));
    try {
      final d = await _uc(orderId);
      emit(LaundryTrackingState(status: LoadStatus.success, data: d));
    } catch (_) {
      emit(LaundryTrackingState(status: LoadStatus.failure, message: AppStrings.networkError));
    }
  }

  Future<void> retry() => load();
}
