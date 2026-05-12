import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/util/load_status.dart';
import '../../../../domain/entities/entities.dart';
import '../../../../domain/usecases/usecases.dart';

class HubState extends Equatable {
  const HubState({
    required this.status,
    this.data,
    this.message,
  });

  final LoadStatus status;
  final HubSummary? data;
  final String? message;

  HubState copyWith({
    LoadStatus? status,
    HubSummary? data,
    String? message,
  }) {
    return HubState(
      status: status ?? this.status,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, data, message];
}

class HubCubit extends Cubit<HubState> {
  HubCubit(this._getHubSummary) : super(const HubState(status: LoadStatus.initial));

  final GetHubSummary _getHubSummary;

  Future<void> load() async {
    emit(state.copyWith(status: LoadStatus.loading, message: null));
    try {
      final data = await _getHubSummary();
      emit(HubState(status: LoadStatus.success, data: data));
    } catch (_) {
      emit(state.copyWith(status: LoadStatus.failure, message: AppStrings.networkError));
    }
  }

  Future<void> retry() => load();
}
