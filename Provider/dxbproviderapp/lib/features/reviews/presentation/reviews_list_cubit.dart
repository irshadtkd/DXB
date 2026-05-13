import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../data/reviews_repository.dart';

sealed class ReviewsListState extends Equatable {
  const ReviewsListState();
  @override
  List<Object?> get props => [];
}

class ReviewsListInitial extends ReviewsListState {
  const ReviewsListInitial();
}

class ReviewsListLoading extends ReviewsListState {
  const ReviewsListLoading();
}

class ReviewsListLoaded extends ReviewsListState {
  const ReviewsListLoaded(this.items);
  final List<dynamic> items;
  @override
  List<Object?> get props => [items];
}

class ReviewsListEmpty extends ReviewsListState {
  const ReviewsListEmpty();
}

class ReviewsListFailure extends ReviewsListState {
  const ReviewsListFailure(this.failure);
  final Failure failure;
  @override
  List<Object?> get props => [failure];
}

class ReviewsListCubit extends Cubit<ReviewsListState> {
  ReviewsListCubit(this._repo) : super(const ReviewsListInitial());
  final ReviewsRepository _repo;

  Future<void> load() async {
    emit(const ReviewsListLoading());
    try {
      final list = await _repo.fetchReviews();
      if (list.isEmpty) {
        emit(const ReviewsListEmpty());
      } else {
        emit(ReviewsListLoaded(list));
      }
    } catch (e) {
      emit(ReviewsListFailure(mapExceptionToFailure(e)));
    }
  }
}
