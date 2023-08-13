import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookain/core/cubits/firestore_query_cubit/firestore_query_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QueryListViewBuilder<
  C extends FirestoreQueryCubit<T>,
  T
>  extends StatelessWidget {

  final Widget Function(BuildContext context)? loadingBuilder;
  final Widget Function(BuildContext context, String error)? errorBuilder;
  final Widget Function(BuildContext context) emptyBuilder;
  final Widget Function(BuildContext context, QueryDocumentSnapshot<T> document) itemBuilder;

  const QueryListViewBuilder({
    Key? key,
    this.loadingBuilder,
    this.errorBuilder,
    required this.emptyBuilder,
    required this.itemBuilder
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<C, FirestoreQueryState<T>>(
      builder: (context, state) {
        if (state is FirestoreQueryInitial<T>) {
          return loadingBuilder?.call(context)
            ?? const Center(child: CircularProgressIndicator(),);
        }
        else if (state is FirestoreQueryError<T>) {
          return errorBuilder?.call(context, state.error)
            ?? Center(child: Text(state.error),);
        }
        else if (state is FirestoreQueryEmpty) {
          return emptyBuilder(context);
        }
        else if (state is FirestoreQueryLoaded<T>) {
          return ListView.builder(
            itemCount: state.docs.length,
            itemBuilder: (context, index) {

              if (index == state.docs.length - 1) {
                context.read<C>().fetchMore();
              }
              final doc = state.docs[index];
              return itemBuilder(context, doc);
            }
          );
        }
        else {
          throw UnimplementedError("Missing implementation for ${state.runtimeType}");
        }
      }
    );
  }
}
