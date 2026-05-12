import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/util/load_status.dart';
import '../../../../domain/entities/entities.dart';
import '../../../../domain/usecases/usecases.dart';

class CheckoutState extends Equatable {
  const CheckoutState({
    required this.status,
    this.data,
    this.message,
    this.selectedPaymentId,
  });

  final LoadStatus status;
  final CheckoutData? data;
  final String? message;
  final String? selectedPaymentId;

  CheckoutState copyWith({
    LoadStatus? status,
    CheckoutData? data,
    String? message,
    String? selectedPaymentId,
  }) {
    return CheckoutState(
      status: status ?? this.status,
      data: data ?? this.data,
      message: message ?? this.message,
      selectedPaymentId: selectedPaymentId ?? this.selectedPaymentId,
    );
  }

  @override
  List<Object?> get props => [status, data, message, selectedPaymentId];
}

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit(this._get, this.orderId) : super(const CheckoutState(status: LoadStatus.initial));

  final GetCheckout _get;
  final String orderId;

  Future<void> load() async {
    emit(const CheckoutState(status: LoadStatus.loading));
    try {
      final d = await _get(orderId);
      var sel = d.paymentMethods.first.id;
      for (final p in d.paymentMethods) {
        if (p.selected) {
          sel = p.id;
          break;
        }
      }
      emit(CheckoutState(status: LoadStatus.success, data: d, selectedPaymentId: sel));
    } catch (_) {
      emit(const CheckoutState(status: LoadStatus.failure, message: AppStrings.networkError));
    }
  }

  void selectPayment(String id) => emit(state.copyWith(selectedPaymentId: id));
}
