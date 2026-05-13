import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../data/reviews_repository.dart';

sealed class ReviewDetailState extends Equatable {
  const ReviewDetailState();
  @override
  List<Object?> get props => [];
}

class ReviewDetailInitial extends ReviewDetailState {
  const ReviewDetailInitial();
}

class ReviewDetailLoading extends ReviewDetailState {
  const ReviewDetailLoading();
}

class ReviewDetailLoaded extends ReviewDetailState {
  const ReviewDetailLoaded(this.data);
  final Map<String, dynamic> data;
  @override
  List<Object?> get props => [data];
}

class ReviewDetailFailure extends ReviewDetailState {
  const ReviewDetailFailure(this.failure);
  final Failure failure;
  @override
  List<Object?> get props => [failure];
}

class ReviewDetailEmpty extends ReviewDetailState {
  const ReviewDetailEmpty();
}

class ReviewDetailCubit extends Cubit<ReviewDetailState> {
  ReviewDetailCubit(this._repo) : super(const ReviewDetailInitial());
  final ReviewsRepository _repo;

  Future<void> load(String id) async {
    emit(const ReviewDetailLoading());
    try {
      final data = await _repo.fetchReview(id);
      if (data == null) {
        emit(const ReviewDetailEmpty());
      } else {
        emit(ReviewDetailLoaded(data));
      }
    } catch (e) {
      emit(ReviewDetailFailure(mapExceptionToFailure(e)));
    }
  }
}
