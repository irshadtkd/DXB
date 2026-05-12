import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/util/load_status.dart';
import '../../../../domain/entities/entities.dart';
import '../../../../domain/usecases/usecases.dart';

class WalletState extends Equatable {
  const WalletState({required this.status, this.data, this.message});
  final LoadStatus status;
  final WalletData? data;
  final String? message;

  @override
  List<Object?> get props => [status, data, message];
}

class WalletCubit extends Cubit<WalletState> {
  WalletCubit(this._get) : super(const WalletState(status: LoadStatus.initial));
  final GetWallet _get;

  Future<void> load() async {
    emit(const WalletState(status: LoadStatus.loading));
    try {
      final d = await _get();
      emit(WalletState(status: LoadStatus.success, data: d));
    } catch (_) {
      emit(const WalletState(status: LoadStatus.failure, message: AppStrings.networkError));
    }
  }
}
