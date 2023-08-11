part of 'firestore_query_cubit.dart';

@immutable
abstract class FirestoreQueryState<T> extends Equatable {
  const FirestoreQueryState();
}

class FirestoreQueryInitial<T> extends FirestoreQueryState<T> {
  const FirestoreQueryInitial();

  @override
  List<Object?> get props => [];
}

class FirestoreQueryError<T> extends FirestoreQueryState<T> {
  final String error;

  const FirestoreQueryError({
    required this.error
  });
  @override
  List<Object?> get props => [error];
}

class FirestoreQueryEmpty<T> extends FirestoreQueryState<T> {
  const FirestoreQueryEmpty();

  @override
  List<Object?> get props => [];
}

class FirestoreQueryLoaded<T> extends FirestoreQueryState<T> {
  final List<QueryDocumentSnapshot<T>> docs;
  const FirestoreQueryLoaded({
    required this.docs,
  });

  @override
  List<Object?> get props => [docs];
}