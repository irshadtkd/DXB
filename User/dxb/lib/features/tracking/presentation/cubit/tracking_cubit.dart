import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/util/load_status.dart';
import '../../../../domain/entities/entities.dart';
import '../../../../domain/usecases/usecases.dart';

class TrackingState extends Equatable {
  const TrackingState({required this.status, this.data, this.message});
  final LoadStatus status;
  final LiveTrackingData? data;
  final String? message;

  @override
  List<Object?> get props => [status, data, message];
}

class TrackingCubit extends Cubit<TrackingState> {
  TrackingCubit(this._get, this.orderId) : super(const TrackingState(status: LoadStatus.initial));
  final GetLiveTracking _get;
  final String orderId;

  Future<void> load() async {
    emit(const TrackingState(status: LoadStatus.loading));
    try {
      final d = await _get(orderId);
      emit(TrackingState(status: LoadStatus.success, data: d));
    } catch (_) {
      emit(const TrackingState(status: LoadStatus.failure, message: AppStrings.networkError));
    }
  }
}
