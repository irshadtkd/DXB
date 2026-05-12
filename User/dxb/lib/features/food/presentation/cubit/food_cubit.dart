import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/util/load_status.dart';
import '../../../../domain/entities/entities.dart';
import '../../../../domain/usecases/usecases.dart';

class FoodState extends Equatable {
  const FoodState({
    required this.status,
    this.data,
    this.message,
    this.selectedCategoryId = 'all',
  });

  final LoadStatus status;
  final FoodHomeData? data;
  final String? message;
  final String selectedCategoryId;

  FoodState copyWith({
    LoadStatus? status,
    FoodHomeData? data,
    String? message,
    String? selectedCategoryId,
  }) {
    return FoodState(
      status: status ?? this.status,
      data: data ?? this.data,
      message: message ?? this.message,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
    );
  }

  @override
  List<Object?> get props => [status, data, message, selectedCategoryId];
}

class FoodCubit extends Cubit<FoodState> {
  FoodCubit(this._getFoodHome) : super(const FoodState(status: LoadStatus.initial));

  final GetFoodHome _getFoodHome;

  Future<void> load() async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      final data = await _getFoodHome();
      emit(FoodState(status: LoadStatus.success, data: data, selectedCategoryId: state.selectedCategoryId));
    } catch (_) {
      emit(state.copyWith(status: LoadStatus.failure, message: AppStrings.networkError));
    }
  }

  void selectCategory(String id) => emit(state.copyWith(selectedCategoryId: id));

  Future<void> retry() => load();
}
