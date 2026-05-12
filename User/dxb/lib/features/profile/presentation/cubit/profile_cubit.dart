import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/util/load_status.dart';
import '../../../../domain/entities/entities.dart';
import '../../../../domain/usecases/usecases.dart';

class ProfileState extends Equatable {
  const ProfileState({required this.status, this.profile, this.message});

  final LoadStatus status;
  final UserProfile? profile;
  final String? message;

  ProfileState copyWith({LoadStatus? status, UserProfile? profile, String? message}) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, profile, message];
}

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._getUserProfile) : super(const ProfileState(status: LoadStatus.initial));

  final GetUserProfile _getUserProfile;

  Future<void> load() async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      final p = await _getUserProfile();
      emit(ProfileState(status: LoadStatus.success, profile: p));
    } catch (_) {
      emit(state.copyWith(status: LoadStatus.failure, message: AppStrings.networkError));
    }
  }

  Future<void> retry() => load();
}
