import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../data/inbox_repository.dart';

sealed class ChatState extends Equatable {
  const ChatState();
  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {
  const ChatInitial();
}

class ChatLoading extends ChatState {
  const ChatLoading();
}

class ChatLoaded extends ChatState {
  const ChatLoaded(this.messages);
  final List<dynamic> messages;
  @override
  List<Object?> get props => [messages];
}

class ChatFailure extends ChatState {
  const ChatFailure(this.failure);
  final Failure failure;
  @override
  List<Object?> get props => [failure];
}

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this._repo) : super(const ChatInitial());
  final InboxRepository _repo;

  Future<void> load(String threadId) async {
    emit(const ChatLoading());
    try {
      final m = await _repo.fetchMessages(threadId);
      emit(ChatLoaded(m));
    } catch (e) {
      emit(ChatFailure(mapExceptionToFailure(e)));
    }
  }
}
