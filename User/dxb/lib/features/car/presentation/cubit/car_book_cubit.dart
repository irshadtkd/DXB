import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/util/load_status.dart';
import '../../../../domain/entities/entities.dart';
import '../../../../domain/usecases/usecases.dart';

class CarBookState extends Equatable {
  const CarBookState({required this.status, this.data, this.message});
  final LoadStatus status;
  final CarBookingData? data;
  final String? message;

  @override
  List<Object?> get props => [status, data, message];
}

class CarBookCubit extends Cubit<CarBookState> {
  CarBookCubit(this._get, this.vehicleId) : super(const CarBookState(status: LoadStatus.initial));

  final GetCarBooking _get;
  final String vehicleId;

  Future<void> load() async {
    emit(const CarBookState(status: LoadStatus.loading));
    try {
      final d = await _get(vehicleId);
      emit(CarBookState(status: LoadStatus.success, data: d));
    } catch (_) {
      emit(const CarBookState(status: LoadStatus.failure, message: AppStrings.networkError));
    }
  }
}
