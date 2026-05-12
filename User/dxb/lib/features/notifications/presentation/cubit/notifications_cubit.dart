import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/util/load_status.dart';
import '../../../../domain/entities/entities.dart';
import '../../../../domain/usecases/usecases.dart';

class NotificationsState extends Equatable {
  const NotificationsState({required this.status, this.items = const [], this.message});
  final LoadStatus status;
  final List<AppNotification> items;
  final String? message;

  @override
  List<Object?> get props => [status, items, message];
}

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._get) : super(const NotificationsState(status: LoadStatus.initial));
  final GetNotifications _get;

  Future<void> load() async {
    emit(const NotificationsState(status: LoadStatus.loading));
    try {
      final list = await _get();
      emit(NotificationsState(status: LoadStatus.success, items: list));
    } catch (_) {
      emit(const NotificationsState(status: LoadStatus.failure, message: AppStrings.networkError));
    }
  }
}
