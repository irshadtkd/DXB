import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/util/load_status.dart';
import '../../../../domain/entities/entities.dart';
import '../../../../domain/usecases/usecases.dart';

class LaundrySummaryState extends Equatable {
  const LaundrySummaryState({required this.status, this.data, this.message});
  final LoadStatus status;
  final LaundryOrderSummary? data;
  final String? message;

  @override
  List<Object?> get props => [status, data, message];
}

class LaundrySummaryCubit extends Cubit<LaundrySummaryState> {
  LaundrySummaryCubit(this._uc) : super(const LaundrySummaryState(status: LoadStatus.initial));
  final GetLaundryOrderSummary _uc;

  Future<void> load() async {
    emit(const LaundrySummaryState(status: LoadStatus.loading));
    try {
      final d = await _uc();
      emit(LaundrySummaryState(status: LoadStatus.success, data: d));
    } catch (_) {
      emit(LaundrySummaryState(status: LoadStatus.failure, message: AppStrings.networkError));
    }
  }

  Future<void> retry() => load();
}
