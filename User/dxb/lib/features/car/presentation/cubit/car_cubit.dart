import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/util/load_status.dart';
import '../../../../domain/entities/entities.dart';
import '../../../../domain/usecases/usecases.dart';

class CarState extends Equatable {
  const CarState({required this.status, this.vehicles = const [], this.message});
  final LoadStatus status;
  final List<Vehicle> vehicles;
  final String? message;

  @override
  List<Object?> get props => [status, vehicles, message];
}

class CarCubit extends Cubit<CarState> {
  CarCubit(this._get) : super(const CarState(status: LoadStatus.initial));
  final GetVehicles _get;

  Future<void> load() async {
    emit(const CarState(status: LoadStatus.loading));
    try {
      final v = await _get();
      emit(CarState(status: LoadStatus.success, vehicles: v));
    } catch (_) {
      emit(CarState(status: LoadStatus.failure, message: AppStrings.networkError));
    }
  }

  Future<void> retry() => load();
}
