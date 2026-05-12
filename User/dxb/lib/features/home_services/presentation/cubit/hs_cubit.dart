import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/util/load_status.dart';
import '../../../../domain/entities/entities.dart';
import '../../../../domain/usecases/usecases.dart';

class HsState extends Equatable {
  const HsState({required this.status, this.bundle, this.message});
  final LoadStatus status;
  final HomeServicesBundle? bundle;
  final String? message;

  @override
  List<Object?> get props => [status, bundle, message];
}

class HsCubit extends Cubit<HsState> {
  HsCubit(this._get) : super(const HsState(status: LoadStatus.initial));
  final GetHomeServices _get;

  Future<void> load() async {
    emit(const HsState(status: LoadStatus.loading));
    try {
      final b = await _get();
      emit(HsState(status: LoadStatus.success, bundle: b));
    } catch (_) {
      emit(const HsState(status: LoadStatus.failure, message: AppStrings.networkError));
    }
  }
}
