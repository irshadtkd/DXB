import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/util/load_status.dart';
import '../../../../domain/entities/entities.dart';
import '../../../../domain/usecases/usecases.dart';

class ChatState extends Equatable {
  const ChatState({required this.status, this.thread, this.message});
  final LoadStatus status;
  final ChatThread? thread;
  final String? message;

  @override
  List<Object?> get props => [status, thread, message];
}

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this._get, this.threadId) : super(const ChatState(status: LoadStatus.initial));
  final GetChatThread _get;
  final String threadId;

  Future<void> load() async {
    emit(const ChatState(status: LoadStatus.loading));
    try {
      final t = await _get(threadId);
      emit(ChatState(status: LoadStatus.success, thread: t));
    } catch (_) {
      emit(const ChatState(status: LoadStatus.failure, message: AppStrings.networkError));
    }
  }
}
