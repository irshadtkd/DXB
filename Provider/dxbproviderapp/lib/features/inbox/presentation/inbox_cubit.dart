import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../data/inbox_repository.dart';

sealed class InboxState extends Equatable {
  const InboxState();
  @override
  List<Object?> get props => [];
}

class InboxInitial extends InboxState {
  const InboxInitial();
}

class InboxLoading extends InboxState {
  const InboxLoading();
}

class InboxLoaded extends InboxState {
  const InboxLoaded(this.threads);
  final List<dynamic> threads;
  @override
  List<Object?> get props => [threads];
}

class InboxEmpty extends InboxState {
  const InboxEmpty();
}

class InboxFailure extends InboxState {
  const InboxFailure(this.failure);
  final Failure failure;
  @override
  List<Object?> get props => [failure];
}

class InboxCubit extends Cubit<InboxState> {
  InboxCubit(this._repo) : super(const InboxInitial());
  final InboxRepository _repo;

  Future<void> load() async {
    emit(const InboxLoading());
    try {
      final t = await _repo.fetchThreads();
      if (t.isEmpty) {
        emit(const InboxEmpty());
      } else {
        emit(InboxLoaded(t));
      }
    } catch (e) {
      emit(InboxFailure(mapExceptionToFailure(e)));
    }
  }
}
