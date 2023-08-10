import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class DialogFormGenericCubit<S> extends Cubit<S> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DialogFormGenericCubit(super.initialState);

  void init();

  Future<bool> upload();

  bool get canEditName;
}
