import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../data/settings_repository.dart';

sealed class SettingsMapState extends Equatable {
  const SettingsMapState();
  @override
  List<Object?> get props => [];
}

class SettingsMapInitial extends SettingsMapState {
  const SettingsMapInitial();
}

class SettingsMapLoading extends SettingsMapState {
  const SettingsMapLoading();
}

class SettingsMapLoaded extends SettingsMapState {
  const SettingsMapLoaded(this.data);
  final Map<String, dynamic> data;
  @override
  List<Object?> get props => [data];
}

class SettingsMapFailure extends SettingsMapState {
  const SettingsMapFailure(this.failure);
  final Failure failure;
  @override
  List<Object?> get props => [failure];
}

class BusinessProfileCubit extends Cubit<SettingsMapState> {
  BusinessProfileCubit(this._repo) : super(const SettingsMapInitial());
  final SettingsRepository _repo;

  Future<void> load() async {
    emit(const SettingsMapLoading());
    try {
      emit(SettingsMapLoaded(await _repo.businessProfile()));
    } catch (e) {
      emit(SettingsMapFailure(mapExceptionToFailure(e)));
    }
  }
}

class ServiceAreasCubit extends Cubit<SettingsMapState> {
  ServiceAreasCubit(this._repo) : super(const SettingsMapInitial());
  final SettingsRepository _repo;

  Future<void> load() async {
    emit(const SettingsMapLoading());
    try {
      emit(SettingsMapLoaded(await _repo.serviceAreas()));
    } catch (e) {
      emit(SettingsMapFailure(mapExceptionToFailure(e)));
    }
  }
}

class OperatingHoursCubit extends Cubit<SettingsMapState> {
  OperatingHoursCubit(this._repo) : super(const SettingsMapInitial());
  final SettingsRepository _repo;

  Future<void> load() async {
    emit(const SettingsMapLoading());
    try {
      emit(SettingsMapLoaded(await _repo.operatingHours()));
    } catch (e) {
      emit(SettingsMapFailure(mapExceptionToFailure(e)));
    }
  }
}

class TeamRolesCubit extends Cubit<SettingsMapState> {
  TeamRolesCubit(this._repo) : super(const SettingsMapInitial());
  final SettingsRepository _repo;

  Future<void> load() async {
    emit(const SettingsMapLoading());
    try {
      emit(SettingsMapLoaded(await _repo.teamRoles()));
    } catch (e) {
      emit(SettingsMapFailure(mapExceptionToFailure(e)));
    }
  }
}

class NotificationPrefsCubit extends Cubit<SettingsMapState> {
  NotificationPrefsCubit(this._repo) : super(const SettingsMapInitial());
  final SettingsRepository _repo;

  Future<void> load() async {
    emit(const SettingsMapLoading());
    try {
      emit(SettingsMapLoaded(await _repo.notificationPrefs()));
    } catch (e) {
      emit(SettingsMapFailure(mapExceptionToFailure(e)));
    }
  }
}

class HelpCenterCubit extends Cubit<SettingsMapState> {
  HelpCenterCubit(this._repo) : super(const SettingsMapInitial());
  final SettingsRepository _repo;

  Future<void> load() async {
    emit(const SettingsMapLoading());
    try {
      emit(SettingsMapLoaded(await _repo.helpTopics()));
    } catch (e) {
      emit(SettingsMapFailure(mapExceptionToFailure(e)));
    }
  }
}

class WebToolsCubit extends Cubit<SettingsMapState> {
  WebToolsCubit(this._repo) : super(const SettingsMapInitial());
  final SettingsRepository _repo;

  Future<void> load() async {
    emit(const SettingsMapLoading());
    try {
      emit(SettingsMapLoaded(await _repo.webTools()));
    } catch (e) {
      emit(SettingsMapFailure(mapExceptionToFailure(e)));
    }
  }
}
