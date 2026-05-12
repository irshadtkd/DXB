import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/util/load_status.dart';
import '../../../../domain/entities/entities.dart';
import '../../../../domain/usecases/usecases.dart';

class HelpState extends Equatable {
  const HelpState({required this.status, this.faqs = const [], this.contacts = const [], this.message});
  final LoadStatus status;
  final List<FaqItem> faqs;
  final List<ContactOption> contacts;
  final String? message;

  @override
  List<Object?> get props => [status, faqs, contacts, message];
}

class HelpCubit extends Cubit<HelpState> {
  HelpCubit(this._get) : super(const HelpState(status: LoadStatus.initial));
  final GetHelpSupport _get;

  Future<void> load() async {
    emit(const HelpState(status: LoadStatus.loading));
    try {
      final r = await _get();
      emit(HelpState(status: LoadStatus.success, faqs: r.faqs, contacts: r.contacts));
    } catch (_) {
      emit(const HelpState(status: LoadStatus.failure, message: AppStrings.networkError));
    }
  }
}
