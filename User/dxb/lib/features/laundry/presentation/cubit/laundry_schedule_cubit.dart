import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/util/load_status.dart';
import '../../../../domain/entities/entities.dart';
import '../../../../domain/usecases/usecases.dart';

class LaundryScheduleState extends Equatable {
  const LaundryScheduleState({
    required this.status,
    this.base,
    this.message,
    this.selectedDateIndex = 0,
    this.selectedSlotId,
    this.selectedTypeIds = const {},
    this.weightUnits = 3,
  });

  final LoadStatus status;
  final LaundryScheduleData? base;
  final String? message;
  final int selectedDateIndex;
  final String? selectedSlotId;
  final Set<String> selectedTypeIds;
  final int weightUnits;

  LaundryScheduleState copyWith({
    LoadStatus? status,
    LaundryScheduleData? base,
    String? message,
    int? selectedDateIndex,
    String? selectedSlotId,
    Set<String>? selectedTypeIds,
    int? weightUnits,
  }) {
    return LaundryScheduleState(
      status: status ?? this.status,
      base: base ?? this.base,
      message: message ?? this.message,
      selectedDateIndex: selectedDateIndex ?? this.selectedDateIndex,
      selectedSlotId: selectedSlotId ?? this.selectedSlotId,
      selectedTypeIds: selectedTypeIds ?? this.selectedTypeIds,
      weightUnits: weightUnits ?? this.weightUnits,
    );
  }

  @override
  List<Object?> get props =>
      [status, base, message, selectedDateIndex, selectedSlotId, selectedTypeIds, weightUnits];
}

class LaundryScheduleCubit extends Cubit<LaundryScheduleState> {
  LaundryScheduleCubit(this._uc) : super(const LaundryScheduleState(status: LoadStatus.initial));
  final GetLaundrySchedule _uc;

  Future<void> load() async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      final b = await _uc();
      final types = b.laundryTypes.where((t) => t.selected).map((t) => t.id).toSet();
      var slotId = b.timeSlots.first.id;
      for (final t in b.timeSlots) {
        if (t.selected) {
          slotId = t.id;
          break;
        }
      }
      emit(LaundryScheduleState(
        status: LoadStatus.success,
        base: b,
        selectedDateIndex: b.dates.indexWhere((d) => d.selected).clamp(0, b.dates.length - 1),
        selectedSlotId: slotId,
        selectedTypeIds: types,
        weightUnits: b.weightUnits,
      ));
    } catch (_) {
      emit(state.copyWith(status: LoadStatus.failure, message: AppStrings.networkError));
    }
  }

  void selectDate(int i) => emit(state.copyWith(selectedDateIndex: i));
  void selectSlot(String id) => emit(state.copyWith(selectedSlotId: id));
  void toggleType(String id) {
    final next = {...state.selectedTypeIds};
    if (next.contains(id)) {
      next.remove(id);
    } else {
      next.add(id);
    }
    emit(state.copyWith(selectedTypeIds: next));
  }

  void bumpWeight(int delta) {
    final v = (state.weightUnits + delta).clamp(1, 20);
    emit(state.copyWith(weightUnits: v));
  }

  Future<void> retry() => load();
}
