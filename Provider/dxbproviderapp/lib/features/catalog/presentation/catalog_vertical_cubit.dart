import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../data/catalog_repository.dart';

sealed class CatalogVerticalState extends Equatable {
  const CatalogVerticalState();
  @override
  List<Object?> get props => [];
}

class CatalogVerticalInitial extends CatalogVerticalState {
  const CatalogVerticalInitial();
}

class CatalogVerticalLoading extends CatalogVerticalState {
  const CatalogVerticalLoading();
}

class CatalogVerticalLoaded extends CatalogVerticalState {
  const CatalogVerticalLoaded(this.vertical, this.data);
  final CatalogVertical vertical;
  final Map<String, dynamic> data;
  @override
  List<Object?> get props => [vertical, data];
}

class CatalogVerticalFailure extends CatalogVerticalState {
  const CatalogVerticalFailure(this.failure);
  final Failure failure;
  @override
  List<Object?> get props => [failure];
}

class CatalogVerticalCubit extends Cubit<CatalogVerticalState> {
  CatalogVerticalCubit(this._repo) : super(const CatalogVerticalInitial());
  final CatalogRepository _repo;

  Future<void> load(CatalogVertical v) async {
    emit(const CatalogVerticalLoading());
    try {
      final data = await _repo.loadVertical(v);
      emit(CatalogVerticalLoaded(v, data));
    } catch (e) {
      emit(CatalogVerticalFailure(mapExceptionToFailure(e)));
    }
  }
}
