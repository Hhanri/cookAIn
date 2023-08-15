import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'firestore_query_state.dart';

abstract class FirestoreQueryCubit<T> extends Cubit<FirestoreQueryState<T>> {
  final Query<T> query;
  final int pageSize;
  FirestoreQueryCubit({
    required this.query,
    this.pageSize = 5
  }) : super(FirestoreQueryInitial<T>());

  bool _hasMore = true;
  bool _isFetching = false;
  int _pageCount = 0;

  StreamSubscription? _querySubscription;
  List<QueryDocumentSnapshot<T>> docs = [];

  void fetchMore() {
    if (_isFetching || !_hasMore) return;
    _pageCount++;
    _fetch();
  }

  void _fetch() {
    _querySubscription?.cancel();

    _isFetching = true;

    final expectedDocsCount = (_pageCount+1) * pageSize;

    final newQuery = query.limit(expectedDocsCount);

    _querySubscription = newQuery.snapshots().listen(
      (event) {
        _isFetching = false;

        _hasMore = event.size >= expectedDocsCount;

        docs = _hasMore
          ? event.docs
          : event.docs.take(expectedDocsCount - 1).toList();

        if (docs.isEmpty) {
          emit(FirestoreQueryEmpty<T>());
        } else {
          emit(FirestoreQueryLoaded(docs: docs));
        }

      },
      onError: (error, stackTrace) {
        _isFetching = false;
        _hasMore = false;
        if (error is FirebaseException) {
          emit(FirestoreQueryError(error: error.message ?? "firebase error"));
        } else {
          emit(FirestoreQueryError(error: error));
        }
      }
    );
  }

  @override
  Future<void> close() async {
    _querySubscription?.cancel();
    return super.close();
  }
}
