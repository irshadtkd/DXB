import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../data/catalog_repository.dart';

sealed class CatalogHubState extends Equatable {
  const CatalogHubState();
  @override
  List<Object?> get props => [];
}

class CatalogHubInitial extends CatalogHubState {
  const CatalogHubInitial();
}

class CatalogHubLoading extends CatalogHubState {
  const CatalogHubLoading();
}

class CatalogHubLoaded extends CatalogHubState {
  const CatalogHubLoaded(this.data);
  final Map<String, dynamic> data;
  @override
  List<Object?> get props => [data];
}

class CatalogHubFailure extends CatalogHubState {
  const CatalogHubFailure(this.failure);
  final Failure failure;
  @override
  List<Object?> get props => [failure];
}

class CatalogHubCubit extends Cubit<CatalogHubState> {
  CatalogHubCubit(this._repo) : super(const CatalogHubInitial());
  final CatalogRepository _repo;

  Future<void> load() async {
    emit(const CatalogHubLoading());
    try {
      final data = await _repo.loadVertical(CatalogVertical.hub);
      emit(CatalogHubLoaded(data));
    } catch (e) {
      emit(CatalogHubFailure(mapExceptionToFailure(e)));
    }
  }
}
